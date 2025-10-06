package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.dto.response.UserResponse;
import com.example.studentanalysissystem.service.StudentService;
import com.example.studentanalysissystem.service.TeacherService;
import com.example.studentanalysissystem.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理员控制器
 * 提供管理员专属的管理功能
 */
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
@Tag(name = "管理员管理", description = "管理员专属的系统管理接口")
@SecurityRequirement(name = "Bearer Authentication")
public class AdminController {

    private final UserService userService;
    private final StudentService studentService;
    private final TeacherService teacherService;

    /**
     * 获取系统统计数据
     */
    @GetMapping("/statistics")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "获取系统统计数据", description = "获取用户、学生、教师、课程等统计信息")
    public ResponseEntity<Map<String, Object>> getStatistics() {
        Map<String, Object> stats = new HashMap<>();

        // 获取学生和教师数量
        long studentCount = studentService.getAllStudents().size();
        long teacherCount = teacherService.getAllTeachers().size();
        long totalUsers = studentCount + teacherCount + 1; // +1 for admin

        stats.put("totalUsers", totalUsers);
        stats.put("studentCount", studentCount);
        stats.put("teacherCount", teacherCount);
        stats.put("adminCount", 1);

        return ResponseEntity.ok(stats);
    }

    /**
     * 获取所有用户列表(包括学生和教师)
     */
    @GetMapping("/users")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "获取所有用户", description = "获取系统中所有用户的列表")
    public ResponseEntity<Map<String, Object>> getAllUsers() {
        Map<String, Object> result = new HashMap<>();

        result.put("students", studentService.getAllStudents());
        result.put("teachers", teacherService.getAllTeachers());

        return ResponseEntity.ok(result);
    }

    /**
     * 删除用户(软删除或硬删除)
     */
    @DeleteMapping("/users/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "删除用户", description = "删除指定ID的用户")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return ResponseEntity.ok().build();
    }

    /**
     * 重置用户密码
     */
    @PutMapping("/users/{id}/reset-password")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "重置用户密码", description = "管理员重置指定用户的密码为默认密码")
    public ResponseEntity<Map<String, String>> resetPassword(@PathVariable Long id) {
        String newPassword = "password123"; // 默认密码
        userService.resetPassword(id, newPassword);

        Map<String, String> response = new HashMap<>();
        response.put("message", "密码重置成功");
        response.put("newPassword", newPassword);

        return ResponseEntity.ok(response);
    }

    /**
     * 批量删除用户
     */
    @DeleteMapping("/users/batch")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "批量删除用户", description = "批量删除多个用户")
    public ResponseEntity<Map<String, Object>> batchDeleteUsers(@RequestBody List<Long> userIds) {
        int deletedCount = 0;
        for (Long id : userIds) {
            try {
                userService.deleteUser(id);
                deletedCount++;
            } catch (Exception e) {
                // 记录错误但继续删除其他用户
                System.err.println("删除用户失败: " + id + ", 错误: " + e.getMessage());
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("totalRequested", userIds.size());
        response.put("deletedCount", deletedCount);
        response.put("failedCount", userIds.size() - deletedCount);

        return ResponseEntity.ok(response);
    }

    /**
     * 启用/禁用用户账户
     */
    @PatchMapping("/users/{id}/toggle-status")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "切换用户状态", description = "启用或禁用用户账户")
    public ResponseEntity<UserResponse> toggleUserStatus(@PathVariable Long id) {
        UserResponse user = userService.getUserById(id);

        // 切换状态
        String newStatus = "ACTIVE".equals(user.getStatus()) ? "INACTIVE" : "ACTIVE";
        UserResponse updatedUser = userService.updateUserStatus(id,
                com.example.studentanalysissystem.model.User.UserStatus.valueOf(newStatus));

        return ResponseEntity.ok(updatedUser);
    }

    /**
     * 获取最近注册的用户
     */
    @GetMapping("/users/recent")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "获取最近注册用户", description = "获取最近注册的用户列表")
    public ResponseEntity<List<UserResponse>> getRecentUsers(
            @RequestParam(defaultValue = "10") int limit) {
        List<UserResponse> recentUsers = userService.getRecentUsers(limit);
        return ResponseEntity.ok(recentUsers);
    }

    /**
     * 搜索用户
     */
    @GetMapping("/users/search")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "搜索用户", description = "根据关键词搜索用户")
    public ResponseEntity<List<UserResponse>> searchUsers(
            @RequestParam String keyword) {
        List<UserResponse> users = userService.searchUsers(keyword);
        return ResponseEntity.ok(users);
    }
}
