package com.example.studentanalysissystem.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 综合成绩模型
 * 存储学生的综合成绩（平时分+期末分按权重计算）
 */
@Entity
@Table(name = "comprehensive_grades")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ComprehensiveGrade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    /**
     * 平时分总分
     */
    @Column(name = "regular_score", precision = 5, scale = 2)
    private BigDecimal regularScore;

    /**
     * 期末分
     */
    @Column(name = "final_score", precision = 5, scale = 2)
    private BigDecimal finalScore;

    /**
     * 补考分
     */
    @Column(name = "makeup_score", precision = 5, scale = 2)
    private BigDecimal makeupScore;

    /**
     * 综合成绩（按权重计算）
     */
    @Column(name = "comprehensive_score", precision = 5, scale = 2)
    private BigDecimal comprehensiveScore;

    /**
     * 最终成绩（考虑补考）
     */
    @Column(name = "final_grade", precision = 5, scale = 2)
    private BigDecimal finalGrade;

    /**
     * 成绩等级（A, B, C, D, F）
     */
    @Column(name = "grade_level", length = 5)
    private String gradeLevel;

    /**
     * 是否通过
     */
    @Column(name = "is_passed", nullable = false)
    @Builder.Default
    private Boolean isPassed = false;

    /**
     * 是否参加补考
     */
    @Column(name = "has_makeup", nullable = false)
    @Builder.Default
    private Boolean hasMakeup = false;

    /**
     * 学期
     */
    @Column(name = "semester", length = 20)
    private String semester;

    /**
     * 学年
     */
    @Column(name = "academic_year", length = 20)
    private String academicYear;

    /**
     * 备注
     */
    @Column(name = "remarks", columnDefinition = "TEXT")
    private String remarks;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    @PreUpdate
    public void calculateFinalGrade() {
        // 计算最终成绩
        if (hasMakeup && makeupScore != null) {
            // 如果参加了补考，使用补考成绩
            finalGrade = makeupScore;
        } else {
            // 否则使用综合成绩
            finalGrade = comprehensiveScore;
        }

        // 计算等级
        if (finalGrade != null) {
            if (finalGrade.compareTo(BigDecimal.valueOf(90)) >= 0) {
                gradeLevel = "A";
            } else if (finalGrade.compareTo(BigDecimal.valueOf(80)) >= 0) {
                gradeLevel = "B";
            } else if (finalGrade.compareTo(BigDecimal.valueOf(70)) >= 0) {
                gradeLevel = "C";
            } else if (finalGrade.compareTo(BigDecimal.valueOf(60)) >= 0) {
                gradeLevel = "D";
            } else {
                gradeLevel = "F";
            }

            // 判断是否通过（60分以上为通过）
            isPassed = finalGrade.compareTo(BigDecimal.valueOf(60)) >= 0;
        }
    }
}
