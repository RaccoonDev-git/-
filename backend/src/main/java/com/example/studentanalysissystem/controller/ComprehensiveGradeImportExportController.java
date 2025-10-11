package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.service.ComprehensiveGradeExportService;
import com.example.studentanalysissystem.service.ComprehensiveGradeImportService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 综合成绩导入导出控制器
 */
@RestController
@RequestMapping("/api/comprehensive-grades")
@RequiredArgsConstructor
@Tag(name = "综合成绩导入导出", description = "综合成绩的导入导出功能")
@CrossOrigin(origins = "*")
public class ComprehensiveGradeImportExportController {

    private final ComprehensiveGradeImportService importService;
    private final ComprehensiveGradeExportService exportService;

    @PostMapping("/import")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "导入综合成绩", description = "从CSV文件导入综合成绩数据")
    public ResponseEntity<Map<String, Object>> importGrades(
            @Parameter(description = "CSV文件") @RequestParam("file") MultipartFile file) {

        Map<String, Object> result = new HashMap<>();

        try {
            ComprehensiveGradeImportService.ImportResult importResult = importService.importComprehensiveGrades(file);

            result.put("success", true);
            result.put("successCount", importResult.getSuccessCount());
            result.put("errorCount", importResult.getErrorCount());
            result.put("errors", importResult.getErrors());
            result.put("message", String.format("导入完成：成功 %d 条，失败 %d 条",
                    importResult.getSuccessCount(), importResult.getErrorCount()));

            return ResponseEntity.ok(result);

        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "导入失败：" + e.getMessage());
            return ResponseEntity.badRequest().body(result);
        }
    }

    @GetMapping("/template")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "下载导入模板", description = "下载综合成绩导入模板")
    public ResponseEntity<byte[]> downloadTemplate() {
        try {
            byte[] template = exportService.generateImportTemplate();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", "comprehensive_grade_import_template.csv");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(template);

        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/course/{courseId}/export")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "导出课程成绩", description = "导出指定课程的综合成绩")
    public ResponseEntity<byte[]> exportCourseGrades(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        try {
            byte[] data = exportService.exportCourseGrades(courseId);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", "course_grades_" + courseId + ".csv");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(data);

        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/student/{studentId}/export")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER', 'STUDENT')")
    @Operation(summary = "导出学生成绩", description = "导出指定学生的综合成绩")
    public ResponseEntity<byte[]> exportStudentGrades(
            @Parameter(description = "学生ID") @PathVariable Long studentId) {
        try {
            byte[] data = exportService.exportStudentGrades(studentId);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", "student_grades_" + studentId + ".csv");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(data);

        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/export/all")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "导出所有成绩", description = "导出所有综合成绩数据")
    public ResponseEntity<byte[]> exportAllGrades() {
        try {
            byte[] data = exportService.exportAllGrades();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", "all_comprehensive_grades.csv");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(data);

        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
