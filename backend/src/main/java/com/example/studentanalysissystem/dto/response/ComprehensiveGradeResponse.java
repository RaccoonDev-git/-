package com.example.studentanalysissystem.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

/**
 * 综合成绩响应DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ComprehensiveGradeResponse {

    private Long id;
    private Long studentId;
    private String studentName;
    private String studentNumber;
    private String studentClass;
    private Long courseId;
    private String courseCode;
    private String courseName;

    /**
     * 平时分总分
     */
    private BigDecimal regularScore;

    /**
     * 平时分各类型详细成绩
     */
    private Map<String, BigDecimal> regularScoreDetails;

    /**
     * 期末分
     */
    private BigDecimal finalScore;

    /**
     * 补考分
     */
    private BigDecimal makeupScore;

    /**
     * 综合成绩（按权重计算）
     */
    private BigDecimal comprehensiveScore;

    /**
     * 最终成绩（考虑补考）
     */
    private BigDecimal finalGrade;

    /**
     * 成绩等级（A, B, C, D, F）
     */
    private String gradeLevel;

    /**
     * 是否通过
     */
    private Boolean isPassed;

    /**
     * 是否参加补考
     */
    private Boolean hasMakeup;

    /**
     * 权重配置信息
     */
    private WeightConfigInfo weightConfig;

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

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /**
     * 权重配置信息
     */
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class WeightConfigInfo {
        private BigDecimal regularWeight;
        private BigDecimal finalWeight;
        private BigDecimal makeupWeight;
    }
}
