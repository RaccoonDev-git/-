package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.dto.request.CreateStudentRequest;
import com.example.studentanalysissystem.dto.request.RegisterRequest;
import com.example.studentanalysissystem.dto.request.UpdateUserRequest;
import com.example.studentanalysissystem.dto.response.StudentResponse;
import com.example.studentanalysissystem.dto.response.UserResponse;
import com.example.studentanalysissystem.exception.ResourceNotFoundException;
import com.example.studentanalysissystem.model.User;
import com.example.studentanalysissystem.service.StudentService;
import com.example.studentanalysissystem.service.TeacherService;
import com.example.studentanalysissystem.service.UserService;
import com.example.studentanalysissystem.service.ExcelExportService;
import com.example.studentanalysissystem.util.StudentImportUtil;
import com.example.studentanalysissystem.util.GradeImportUtil;
import com.example.studentanalysissystem.util.DataNormalizationUtil;
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
    private final ExcelExportService excelExportService;
    private final GradeImportUtil gradeImportUtil;
    private final DataNormalizationUtil dataNormalizationUtil;

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
                if (row == null)
                    continue;

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
        if (cell == null)
            return null;

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

    /**
     * 导出用户列表
     */
    @GetMapping("/users/export")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "导出用户列表", description = "导出所有用户数据为Excel文件")
    public ResponseEntity<byte[]> exportUsers() {
        try {
            List<User> users = userService.findAllUsers();

            Workbook workbook = excelExportService.createWorkbook();
            Sheet sheet = workbook.createSheet("用户列表");

            // 创建样式
            CellStyle headerStyle = excelExportService.createHeaderStyle(workbook);
            CellStyle dataStyle = excelExportService.createDataStyle(workbook);

            // 创建标题行
            List<String> headers = java.util.Arrays.asList(
                    "用户ID", "用户名", "角色", "邮箱", "手机", "状态", "注册时间");
            excelExportService.createHeaderRow(sheet, headers, headerStyle);

            // 填充数据
            int rowNum = 1;
            for (User user : users) {
                Row row = sheet.createRow(rowNum++);
                int colNum = 0;

                excelExportService.setCellValue(row.createCell(colNum++), user.getId(), dataStyle);
                excelExportService.setCellValue(row.createCell(colNum++), user.getUsername(), dataStyle);
                excelExportService.setCellValue(row.createCell(colNum++), user.getRole().name(), dataStyle);
                excelExportService.setCellValue(row.createCell(colNum++), user.getEmail(), dataStyle);
                excelExportService.setCellValue(row.createCell(colNum++), user.getPhone(), dataStyle);
                excelExportService.setCellValue(row.createCell(colNum++), user.getStatus().name(), dataStyle);
                excelExportService.setCellValue(row.createCell(colNum++), user.getCreatedAt(), dataStyle);
            }

            // 自动调整列宽
            for (int i = 0; i < headers.size(); i++) {
                sheet.autoSizeColumn(i);
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 1024);
            }

            byte[] excelData = excelExportService.workbookToBytes(workbook);
            String filename = excelExportService.generateFileName("用户列表");

            return ResponseEntity.ok()
                    .header(org.springframework.http.HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + filename + "\"")
                    .contentType(org.springframework.http.MediaType.APPLICATION_OCTET_STREAM)
                    .body(excelData);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 获取所有学生列表
     */
    @GetMapping("/students")
    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
    @Operation(summary = "获取所有学生", description = "获取系统中所有学生的列表")
    public ResponseEntity<List<StudentResponse>> getAllStudents() {
        try {
            List<StudentResponse> students = studentService.getAllStudents();
            return ResponseEntity.ok(students);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 批量导入学生(支持CSV、Excel、JSON格式)
     */
    @PostMapping("/students/import")
    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
    @Operation(summary = "批量导入学生", description = "从CSV、Excel或JSON文件批量导入学生数据和成绩")
    public ResponseEntity<Map<String, Object>> importStudents(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        List<String> errors = new ArrayList<>();
        List<String> warnings = new ArrayList<>();
        int successCount = 0;
        int failCount = 0;
        int totalGrades = 0;
        List<com.example.studentanalysissystem.model.Student> importedStudents = new ArrayList<>();
        List<Map<String, String>> allRowData = new ArrayList<>();

        try {
            String filename = file.getOriginalFilename();
            if (filename == null) {
                response.put("success", false);
                response.put("message", "文件名不能为空");
                return ResponseEntity.badRequest().body(response);
            }

            // 根据文件扩展名选择解析方式
            String fileType = StudentImportUtil.getFileType(filename);
            List<Map<String, String>> studentDataList;

            switch (fileType) {
                case "csv":
                    studentDataList = StudentImportUtil.parseCSV(file.getInputStream());
                    break;
                case "excel":
                    studentDataList = StudentImportUtil.parseExcel(file.getInputStream());
                    break;
                case "json":
                    studentDataList = StudentImportUtil.parseJSON(file.getInputStream());
                    break;
                default:
                    response.put("success", false);
                    response.put("message", "不支持的文件格式，仅支持 .csv、.xlsx、.xls 和 .json 格式");
                    return ResponseEntity.badRequest().body(response);
            }

            // 处理解析后的数据
            int lineNumber = 1; // 从1开始，表示数据行（不含表头）
            int normalizedCount = 0; // 统计被标准化的数据数量

            for (Map<String, String> studentData : studentDataList) {
                lineNumber++;
                try {
                    // ===== 🔧 自动数据标准化 =====
                    Map<String, String> originalData = new HashMap<>(studentData);
                    Map<String, String> normalizedData = dataNormalizationUtil.normalizeRowData(studentData);

                    // 统计标准化效果
                    if (!originalData.equals(normalizedData)) {
                        normalizedCount++;
                        System.out.println("DEBUG - Line " + lineNumber + " 数据已标准化");
                        System.out.println("  原始数据: " + originalData);
                        System.out.println("  标准化后: " + normalizedData);
                    }

                    // 验证标准化后的数据
                    if (!dataNormalizationUtil.validateNormalizedData(normalizedData)) {
                        String errorMsg = "第" + lineNumber + "行: 数据验证失败，缺少必填字段";
                        errors.add(errorMsg);
                        failCount++;
                        continue;
                    }

                    // 使用标准化后的数据
                    studentData = normalizedData;
                    // ===== ✅ 标准化完成 =====

                    // 调试：打印所有键
                    System.out.println("DEBUG - Line " + lineNumber + " keys: " + studentData.keySet());

                    // 解析数据
                    String name = studentData.getOrDefault("姓名", "").trim();
                    String studentNumber = studentData.getOrDefault("学号", "").trim();
                    String gradeStr = studentData.getOrDefault("年级", "").trim();
                    String className = studentData.getOrDefault("班级", "").trim();
                    String major = studentData.getOrDefault("专业", "").trim();
                    String phone = studentData.getOrDefault("手机号", "").trim();
                    String remarks = studentData.getOrDefault("备注", "").trim();

                    // 调试：打印提取的值
                    System.out.println("DEBUG - Line " + lineNumber + ": name=[" + name + "], studentNumber=["
                            + studentNumber + "]");

                    // 验证必填字段（二次验证）
                    if (name.isEmpty() || studentNumber.isEmpty()) {
                        String errorMsg = "第" + lineNumber + "行: 姓名和学号不能为空 (name='" + name + "', studentNumber='"
                                + studentNumber + "')";
                        errors.add(errorMsg);
                        System.err.println("ERROR - " + errorMsg);
                        failCount++;
                        continue;
                    }

                    // 检查学号是否已存在
                    com.example.studentanalysissystem.model.Student student = null;
                    try {
                        StudentResponse existingStudent = studentService.getStudentByStudentNumber(studentNumber);
                        student = studentService.getStudentEntityById(existingStudent.getId());
                        warnings.add("第" + lineNumber + "行: 学号 " + studentNumber + " 已存在，将更新成绩信息");
                    } catch (ResourceNotFoundException e) {
                        // 学生不存在，创建新学生

                        // 解析年级
                        Integer gradeLevel = null;
                        if (!gradeStr.isEmpty()) {
                            try {
                                gradeLevel = Integer.parseInt(gradeStr);
                            } catch (NumberFormatException ex) {
                                warnings.add("第" + lineNumber + "行: 年级格式错误，使用null");
                            }
                        }

                        // 创建用户账号
                        RegisterRequest registerRequest = new RegisterRequest();
                        registerRequest.setUsername(studentNumber);
                        registerRequest.setPassword("123456");
                        registerRequest.setRole(User.UserRole.STUDENT);
                        registerRequest.setPhone(!phone.isEmpty() ? phone : null);

                        UserResponse userResponse = userService.register(registerRequest);

                        // 创建学生信息
                        CreateStudentRequest studentRequest = CreateStudentRequest.builder()
                                .userId(userResponse.getId())
                                .name(name)
                                .studentNumber(studentNumber)
                                .gradeLevel(gradeLevel)
                                .className(className.isEmpty() ? null : className)
                                .major(major.isEmpty() ? null : major)
                                .remarks(remarks.isEmpty() ? null : remarks)
                                .build();

                        StudentResponse studentResponse = studentService.createStudent(studentRequest);
                        student = studentService.getStudentEntityById(studentResponse.getId());
                        successCount++;
                    }

                    // 保存学生对象和行数据，用于后续批量导入成绩
                    if (student != null) {
                        importedStudents.add(student);
                        allRowData.add(studentData);
                    }

                } catch (Exception e) {
                    errors.add("第" + lineNumber + "行: " + e.getMessage());
                    failCount++;
                }
            }

            // 批量导入成绩
            if (!importedStudents.isEmpty()) {
                try {
                    Map<String, Object> gradeResult = gradeImportUtil.batchImportGrades(importedStudents, allRowData);
                    totalGrades = (int) gradeResult.get("totalGrades");
                    int totalCourses = (int) gradeResult.get("totalCourses");
                    @SuppressWarnings("unchecked")
                    java.util.Set<String> coursesCreated = (java.util.Set<String>) gradeResult.get("coursesCreated");

                    response.put("gradesImported", totalGrades);
                    response.put("coursesCreated", totalCourses);
                    response.put("courseNames", coursesCreated);
                } catch (Exception e) {
                    warnings.add("成绩导入过程中出现错误: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            response.put("success", true);
            response.put("successCount", successCount);
            response.put("failCount", failCount);
            response.put("totalRows", studentDataList.size());
            response.put("normalizedCount", normalizedCount); // 标准化的数据数量
            response.put("errors", errors);
            response.put("warnings", warnings);

            String message = String.format("成功导入 %d 条学生记录，失败 %d 条", successCount, failCount);
            if (normalizedCount > 0) {
                message += String.format("，其中 %d 条数据经过自动格式转换", normalizedCount);
            }
            if (totalGrades > 0) {
                message += String.format("，导入 %d 条成绩记录", totalGrades);
            }
            response.put("message", message);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "文件解析失败: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.internalServerError().body(response);
        }
    }

}