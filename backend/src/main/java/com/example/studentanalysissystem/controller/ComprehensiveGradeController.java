package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.dto.request.CalculateComprehensiveGradeRequest;
import com.example.studentanalysissystem.dto.response.ComprehensiveGradeResponse;
import com.example.studentanalysissystem.service.ComprehensiveGradeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 综合成绩控制器
 */
@RestController
@RequestMapping("/api/comprehensive-grades")
@RequiredArgsConstructor
@Tag(name = "综合成绩管理", description = "综合成绩计算、查询、统计分析")
@CrossOrigin(origins = "*")
public class ComprehensiveGradeController {

    private final ComprehensiveGradeService comprehensiveGradeService;

    @PostMapping("/calculate")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "计算综合成绩", description = "根据平时分和期末分计算综合成绩")
    public ResponseEntity<ComprehensiveGradeResponse> calculateComprehensiveGrade(
            @RequestBody CalculateComprehensiveGradeRequest request) {
        ComprehensiveGradeResponse response = comprehensiveGradeService.calculateComprehensiveGrade(request);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/student/{studentId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER', 'STUDENT')")
    @Operation(summary = "获取学生综合成绩", description = "获取指定学生的所有综合成绩")
    public ResponseEntity<List<ComprehensiveGradeResponse>> getComprehensiveGradesByStudentId(
            @Parameter(description = "学生ID") @PathVariable Long studentId) {
        List<ComprehensiveGradeResponse> grades = comprehensiveGradeService
                .getComprehensiveGradesByStudentId(studentId);
        return ResponseEntity.ok(grades);
    }

    @GetMapping("/course/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取课程综合成绩", description = "获取指定课程的所有综合成绩")
    public ResponseEntity<List<ComprehensiveGradeResponse>> getComprehensiveGradesByCourseId(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        List<ComprehensiveGradeResponse> grades = comprehensiveGradeService.getComprehensiveGradesByCourseId(courseId);
        return ResponseEntity.ok(grades);
    }

    @GetMapping("/student/{studentId}/course/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER', 'STUDENT')")
    @Operation(summary = "获取学生课程综合成绩", description = "获取指定学生在指定课程的综合成绩")
    public ResponseEntity<ComprehensiveGradeResponse> getComprehensiveGradeByStudentAndCourse(
            @Parameter(description = "学生ID") @PathVariable Long studentId,
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        ComprehensiveGradeResponse grade = comprehensiveGradeService.getComprehensiveGradeByStudentAndCourse(studentId,
                courseId);
        return ResponseEntity.ok(grade);
    }

    @PostMapping("/batch-calculate/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "批量计算课程综合成绩", description = "批量计算指定课程的所有学生综合成绩")
    public ResponseEntity<List<ComprehensiveGradeResponse>> batchCalculateComprehensiveGrades(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        List<ComprehensiveGradeResponse> grades = comprehensiveGradeService.batchCalculateComprehensiveGrades(courseId);
        return ResponseEntity.ok(grades);
    }

    @PostMapping("/recalculate-all")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "重新计算所有综合成绩", description = "重新计算所有课程的综合成绩")
    public ResponseEntity<Void> recalculateAllComprehensiveGrades() {
        comprehensiveGradeService.recalculateAllComprehensiveGrades();
        return ResponseEntity.ok().build();
    }

    @PutMapping("/makeup/{studentId}/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "更新补考成绩", description = "更新学生的补考成绩")
    public ResponseEntity<ComprehensiveGradeResponse> updateMakeupScore(
            @Parameter(description = "学生ID") @PathVariable Long studentId,
            @Parameter(description = "课程ID") @PathVariable Long courseId,
            @Parameter(description = "补考成绩") @RequestParam Double makeupScore) {
        ComprehensiveGradeResponse response = comprehensiveGradeService.updateMakeupScore(studentId, courseId,
                makeupScore);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/student/{studentId}/statistics")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER', 'STUDENT')")
    @Operation(summary = "获取学生成绩统计", description = "获取学生的成绩统计信息")
    public ResponseEntity<Object> getStudentGradeStatistics(
            @Parameter(description = "学生ID") @PathVariable Long studentId) {
        Object statistics = comprehensiveGradeService.getStudentGradeStatistics(studentId);
        return ResponseEntity.ok(statistics);
    }

    @GetMapping("/course/{courseId}/statistics")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取课程成绩统计", description = "获取课程的成绩统计信息")
    public ResponseEntity<Object> getCourseGradeStatistics(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        Object statistics = comprehensiveGradeService.getCourseGradeStatistics(courseId);
        return ResponseEntity.ok(statistics);
    }
}
