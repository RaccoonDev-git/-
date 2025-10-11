package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.model.User;
import com.example.studentanalysissystem.repository.UserRepository;
import com.example.studentanalysissystem.security.JwtUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 调试控制器 - 用于调试认证和权限问题
 */
@RestController
@RequestMapping("/api/debug")
@RequiredArgsConstructor
@Slf4j
public class DebugController {

    private final JwtUtil jwtUtil;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    /**
     * 获取当前用户的认证信息
     */
    @GetMapping("/auth-info")
    public ResponseEntity<Map<String, Object>> getAuthInfo(
            @RequestHeader(value = "Authorization", required = false) String authHeader) {

        Map<String, Object> info = new HashMap<>();

        // 获取当前认证信息
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null) {
            info.put("authenticated", authentication.isAuthenticated());
            info.put("principal", authentication.getPrincipal().toString());
            info.put("authorities", authentication.getAuthorities().stream()
                    .map(GrantedAuthority::getAuthority)
                    .collect(Collectors.toList()));
        } else {
            info.put("authenticated", false);
            info.put("message", "未找到认证信息");
        }

        // 解析JWT token
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
                info.put("jwt_username", jwtUtil.extractUsername(token));
                info.put("jwt_role", jwtUtil.extractRole(token));
                info.put("jwt_userId", jwtUtil.extractUserId(token));
                info.put("jwt_valid", jwtUtil.validateToken(token));
            } catch (Exception e) {
                info.put("jwt_error", e.getMessage());
            }
        } else {
            info.put("jwt_error", "未提供JWT token");
        }

        log.info("认证调试信息: {}", info);

        return ResponseEntity.ok(info);
    }

    /**
     * 测试访问 - 需要任意角色
     */
    @GetMapping("/test-authenticated")
    public ResponseEntity<Map<String, String>> testAuthenticated() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Map<String, String> result = new HashMap<>();
        result.put("status", "success");
        result.put("message", "认证成功");
        result.put("user", auth != null ? auth.getName() : "unknown");
        return ResponseEntity.ok(result);
    }

    /**
     * 测试访问 - 需要教师或管理员角色
     */
    @GetMapping("/test-teacher-or-admin")
    public ResponseEntity<Map<String, String>> testTeacherOrAdmin() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Map<String, String> result = new HashMap<>();
        result.put("status", "success");
        result.put("message", "教师或管理员权限验证成功");
        result.put("user", auth != null ? auth.getName() : "unknown");
        result.put("roles", auth != null ? auth.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(", ")) : "none");
        return ResponseEntity.ok(result);
    }

    /**
     * 获取数据库中的所有用户（调试用）
     */
    @GetMapping("/users")
    public ResponseEntity<List<Map<String, Object>>> getUsers() {
        try {
            List<User> users = userRepository.findAll();
            List<Map<String, Object>> userInfo = users.stream()
                    .map(user -> {
                        Map<String, Object> info = new HashMap<>();
                        info.put("id", user.getId());
                        info.put("username", user.getUsername());
                        info.put("role", user.getRole());
                        info.put("email", user.getEmail());
                        info.put("status", user.getStatus());
                        info.put("createdAt", user.getCreatedAt());
                        return info;
                    })
                    .collect(Collectors.toList());

            log.info("Database contains {} users", users.size());
            return ResponseEntity.ok(userInfo);
        } catch (Exception e) {
            log.error("Error retrieving users from database", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 重置指定用户的密码为 password123（调试用）
     */
    @PostMapping("/reset-password/{username}")
    public ResponseEntity<Map<String, String>> resetPassword(@PathVariable String username) {
        try {
            User user = userRepository.findByUsername(username)
                    .orElseThrow(() -> new RuntimeException("User not found: " + username));

            // 使用PasswordEncoder加密 password123
            String encodedPassword = passwordEncoder.encode("password123");
            user.setPassword(encodedPassword);
            userRepository.save(user);

            Map<String, String> result = new HashMap<>();
            result.put("status", "success");
            result.put("message", "Password reset successfully for user: " + username);
            result.put("newPassword", "password123");

            log.info("Password reset for user: {}", username);
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            log.error("Error resetting password for user: {}", username, e);
            Map<String, String> error = new HashMap<>();
            error.put("status", "error");
            error.put("message", "Failed to reset password: " + e.getMessage());
            return ResponseEntity.internalServerError().body(error);
        }
    }
}
