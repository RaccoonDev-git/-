package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.dto.request.RegisterRequest;
import com.example.studentanalysissystem.dto.request.UpdateUserRequest;
import com.example.studentanalysissystem.dto.response.UserResponse;
import com.example.studentanalysissystem.model.User;
import com.example.studentanalysissystem.service.StudentService;
import com.example.studentanalysissystem.service.TeacherService;
import com.example.studentanalysissystem.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
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
     * 更新用户信息
     */
    @PutMapping("/users/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "更新用户信息", description = "更新指定用户的基本信息")
    public ResponseEntity<UserResponse> updateUser(
            @PathVariable Long id,
            @RequestBody UpdateUserRequest request) {
        UserResponse updatedUser = userService.updateUser(id, request);
        return ResponseEntity.ok(updatedUser);
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

    /**
     * 批量导入用户(从Excel文件)
     */
    @PostMapping("/users/import")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "批量导入用户", description = "从Excel文件批量导入用户数据")
    public ResponseEntity<Map<String, Object>> importUsers(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        List<String> errors = new ArrayList<>();
        int successCount = 0;
        int failCount = 0;

        try {
            InputStream inputStream = file.getInputStream();
            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);

            // 跳过标题行,从第二行开始读取
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                try {
                    // 读取单元格数据
                    String username = getCellValue(row.getCell(0));
                    String password = getCellValue(row.getCell(1));
                    String roleStr = getCellValue(row.getCell(2));
                    String email = getCellValue(row.getCell(3));
                    String phone = getCellValue(row.getCell(4));

                    // 验证必填字段
                    if (username == null || username.trim().isEmpty() ||
                        password == null || password.trim().isEmpty() ||
                        roleStr == null || roleStr.trim().isEmpty()) {
                        errors.add("第" + (i + 1) + "行: 用户名、密码、角色不能为空");
                        failCount++;
                        continue;
                    }

                    // 验证角色
                    User.UserRole role;
                    try {
                        role = User.UserRole.valueOf(roleStr.toUpperCase());
                    } catch (IllegalArgumentException e) {
                        errors.add("第" + (i + 1) + "行: 无效的角色 '" + roleStr + "'");
                        failCount++;
                        continue;
                    }

                    // 创建注册请求
                    RegisterRequest registerRequest = new RegisterRequest();
                    registerRequest.setUsername(username.trim());
                    registerRequest.setPassword(password.trim());
                    registerRequest.setRole(role);
                    registerRequest.setEmail(email != null ? email.trim() : null);
                    registerRequest.setPhone(phone != null ? phone.trim() : null);

                    // 注册用户
                    userService.register(registerRequest);
                    successCount++;

                } catch (Exception e) {
                    errors.add("第" + (i + 1) + "行: " + e.getMessage());
                    failCount++;
                }
            }

            workbook.close();
            inputStream.close();

            response.put("success", true);
            response.put("successCount", successCount);
            response.put("failCount", failCount);
            response.put("totalRows", sheet.getLastRowNum());
            response.put("errors", errors);

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "文件解析失败: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 辅助方法: 获取单元格值
     */
    private String getCellValue(Cell cell) {
        if (cell == null) return null;
        
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                return String.valueOf((long) cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return null;
        }
    }

}