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
                "用户ID", "用户名", "角色", "邮箱", "手机", "状态", "注册时间"
            );
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
                            "attachment; filename=\\"" + filename + "\\"")
                    .contentType(org.springframework.http.MediaType.APPLICATION_OCTET_STREAM)
                    .body(excelData);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
"""

# 插入新代码
new_content = content[:last_brace] + new_code + "\n}"

# 写回文件
with open(file_path, "w", encoding="utf-8") as f:
    f.write(new_content)

print("用户导出方法已添加!")
