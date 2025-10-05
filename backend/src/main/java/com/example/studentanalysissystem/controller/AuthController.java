package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.dto.request.LoginRequest;
import com.example.studentanalysissystem.dto.request.RegisterRequest;
import com.example.studentanalysissystem.dto.response.UserResponse;
import com.example.studentanalysissystem.service.UserService;
import com.example.studentanalysissystem.security.JwtUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/authentication")
@Tag(name = "认证管理", description = "用户注册、登录、密码修改等认证相关接口")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/register")
    @Operation(summary = "用户注册", description = "注册新用户账号")
    public ResponseEntity<?> register(@Valid @RequestBody RegisterRequest request) {
        try {
            UserResponse userResponse = userService.register(request);

            // 生成JWT令牌
            String token = jwtUtil.generateToken(
                    userResponse.getUsername(),
                    userResponse.getRole().name(),
                    userResponse.getId());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "注册成功");
            response.put("token", token);
            response.put("user", userResponse);
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "注册失败: " + e.getMessage());
            return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/login")
    @Operation(summary = "用户登录", description = "用户登录验证")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest request) {
        try {
            UserResponse userResponse = userService.login(request);

            // 生成JWT令牌
            String token = jwtUtil.generateToken(
                    userResponse.getUsername(),
                    userResponse.getRole().name(),
                    userResponse.getId());

            Map<String, Object> response = new HashMap<>();
            response.put("message", "登录成功");
            response.put("token", token);
            response.put("user", userResponse);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "登录失败: " + e.getMessage());
            return new ResponseEntity<>(errorResponse, HttpStatus.UNAUTHORIZED);
        }
    }

    @PostMapping("/change-password")
    @Operation(summary = "修改密码", description = "修改用户密码")
    public ResponseEntity<?> changePassword(@RequestBody Map<String, String> passwordData) {
        try {
            Long userId = Long.parseLong(passwordData.get("userId"));
            String oldPassword = passwordData.get("oldPassword");
            String newPassword = passwordData.get("newPassword");

            if (oldPassword == null || oldPassword.isEmpty() || newPassword == null || newPassword.isEmpty()) {
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("message", "旧密码和新密码不能为空");
                return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
            }

            userService.changePassword(userId, oldPassword, newPassword);

            Map<String, String> response = new HashMap<>();
            response.put("message", "密码修改成功");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "密码修改失败: " + e.getMessage());
            return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
        }
    }
}
