#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os

# 读取文件
file_path = r"backend\src\main\java\com\example\studentanalysissystem\controller\AdminController.java"

with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# 找到最后一个}的位置
last_brace = content.rfind("}")

# 要插入的代码
new_code = """
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
"""

# 插入新代码
new_content = content[:last_brace] + new_code + "\n}"

# 写回文件
with open(file_path, "w", encoding="utf-8") as f:
    f.write(new_content)

print("批量导入功能已添加!")
