package com.example.studentanalysissystem.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Map;

/**
 * 计算综合成绩请求DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CalculateComprehensiveGradeRequest {

    @NotNull(message = "学生ID不能为空")
    private Long studentId;

    @NotNull(message = "课程ID不能为空")
    private Long courseId;

    /**
     * 平时分各类型成绩
     * key: 成绩类型代码 (如: ATTENDANCE, HOMEWORK, LAB, QUIZ)
     * value: 成绩
     */
    private Map<String, BigDecimal> regularScores;

    /**
     * 期末分
     */
    private BigDecimal finalScore;

    /**
     * 补考分
     */
    private BigDecimal makeupScore;

    /**
     * 学期
     */
    private String semester;

    /**
     * 学年
     */
    private String academicYear;

    /**
     * 备注
     */
    private String remarks;
}
