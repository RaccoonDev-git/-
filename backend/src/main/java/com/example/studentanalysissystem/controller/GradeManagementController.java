package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.service.GradeRecalculationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 成绩管理控制器
 * 提供成绩重新计算、数据一致性检查等管理功能
 */
@RestController
@RequestMapping("/api/grade-management")
@RequiredArgsConstructor
@Tag(name = "成绩管理", description = "成绩重新计算、数据一致性检查等管理功能")
@CrossOrigin(origins = "*")
public class GradeManagementController {

    private final GradeRecalculationService gradeRecalculationService;

    @PostMapping("/recalculate/course/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "重新计算课程成绩", description = "重新计算指定课程的所有综合成绩")
    public ResponseEntity<String> recalculateCourseGrades(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        try {
            gradeRecalculationService.recalculateCourseGrades(courseId);
            return ResponseEntity.ok("课程" + courseId + "的成绩重新计算完成");
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("重新计算失败: " + e.getMessage());
        }
    }

    @PostMapping("/recalculate/all")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "重新计算所有成绩", description = "重新计算所有课程的综合成绩")
    public ResponseEntity<String> recalculateAllGrades() {
        try {
            gradeRecalculationService.recalculateAllGrades();
            return ResponseEntity.ok("所有课程的成绩重新计算完成");
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("重新计算失败: " + e.getMessage());
        }
    }

    @PostMapping("/check-consistency")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "检查数据一致性", description = "检查并修复成绩数据的一致性")
    public ResponseEntity<String> checkDataConsistency(
            @Parameter(description = "课程ID，不提供则检查所有课程") @RequestParam(required = false) Long courseId) {
        try {
            gradeRecalculationService.checkAndFixDataConsistency(courseId);
            String message = courseId != null ? "课程" + courseId + "的数据一致性检查完成" : "所有课程的数据一致性检查完成";
            return ResponseEntity.ok(message);
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("数据一致性检查失败: " + e.getMessage());
        }
    }
}
