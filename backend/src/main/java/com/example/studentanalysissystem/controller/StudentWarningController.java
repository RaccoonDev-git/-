package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.dto.response.StudentWarningResponse;
import com.example.studentanalysissystem.service.StudentWarningService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 学生预警控制器
 */
@RestController
@RequestMapping("/api/student-warnings")
@RequiredArgsConstructor
@Tag(name = "学生预警管理", description = "学生预警检查、查询、处理")
@CrossOrigin(origins = "*")
public class StudentWarningController {

    private final StudentWarningService studentWarningService;

    @PostMapping("/check/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "检查课程预警", description = "检查指定课程的学生预警")
    public ResponseEntity<Void> checkAndGenerateWarnings(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        studentWarningService.checkAndGenerateWarnings(courseId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/check-all")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "检查所有课程预警", description = "检查所有课程的学生预警")
    public ResponseEntity<Void> checkAndGenerateAllWarnings() {
        studentWarningService.checkAndGenerateAllWarnings();
        return ResponseEntity.ok().build();
    }

    @GetMapping("/student/{studentId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER', 'STUDENT')")
    @Operation(summary = "获取学生预警", description = "获取指定学生的所有预警")
    public ResponseEntity<List<StudentWarningResponse>> getWarningsByStudentId(
            @Parameter(description = "学生ID") @PathVariable Long studentId) {
        List<StudentWarningResponse> warnings = studentWarningService.getWarningsByStudentId(studentId);
        return ResponseEntity.ok(warnings);
    }

    @GetMapping("/course/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取课程预警", description = "获取指定课程的所有预警")
    public ResponseEntity<List<StudentWarningResponse>> getWarningsByCourseId(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        List<StudentWarningResponse> warnings = studentWarningService.getWarningsByCourseId(courseId);
        return ResponseEntity.ok(warnings);
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取预警列表", description = "根据条件获取预警列表")
    public ResponseEntity<List<StudentWarningResponse>> getWarnings(
            @Parameter(description = "预警级别") @RequestParam(required = false) String level,
            @Parameter(description = "处理状态") @RequestParam(required = false) String handled) {
        List<StudentWarningResponse> warnings;
        if (level != null || handled != null) {
            // 根据条件筛选预警
            warnings = studentWarningService.getUnhandledWarnings();
        } else {
            warnings = studentWarningService.getUnhandledWarnings();
        }
        return ResponseEntity.ok(warnings);
    }

    @GetMapping("/unhandled")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取未处理预警", description = "获取所有未处理的预警")
    public ResponseEntity<List<StudentWarningResponse>> getUnhandledWarnings() {
        List<StudentWarningResponse> warnings = studentWarningService.getUnhandledWarnings();
        return ResponseEntity.ok(warnings);
    }

    @PutMapping("/handle/{warningId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "处理预警", description = "处理指定的预警")
    public ResponseEntity<Void> handleWarning(
            @Parameter(description = "预警ID") @PathVariable Long warningId,
            @Parameter(description = "处理人ID") @RequestParam Long handledBy,
            @Parameter(description = "处理备注") @RequestParam(required = false) String handleRemarks) {
        studentWarningService.handleWarning(warningId, handledBy, handleRemarks);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/batch-handle")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "批量处理预警", description = "批量处理多个预警")
    public ResponseEntity<Void> batchHandleWarnings(
            @Parameter(description = "预警ID列表") @RequestBody List<Long> warningIds,
            @Parameter(description = "处理人ID") @RequestParam Long handledBy,
            @Parameter(description = "处理备注") @RequestParam(required = false) String handleRemarks) {
        studentWarningService.batchHandleWarnings(warningIds, handledBy, handleRemarks);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{warningId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "删除预警", description = "删除指定的预警")
    public ResponseEntity<Void> deleteWarning(
            @Parameter(description = "预警ID") @PathVariable Long warningId) {
        studentWarningService.deleteWarning(warningId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/statistics")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取预警统计", description = "获取预警统计信息")
    public ResponseEntity<Object> getWarningStatistics() {
        Object statistics = studentWarningService.getWarningStatistics();
        return ResponseEntity.ok(statistics);
    }
}
