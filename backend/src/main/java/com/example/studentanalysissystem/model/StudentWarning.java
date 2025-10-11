package com.example.studentanalysissystem.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 学生预警模型
 * 记录学生平时分过低的预警信息
 */
@Entity
@Table(name = "student_warnings")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudentWarning {

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
     * 预警类型（LOW_REGULAR_SCORE, ATTENDANCE_POOR, HOMEWORK_MISSING等）
     */
    @Column(name = "warning_type", nullable = false, length = 50)
    private String warningType;

    /**
     * 预警级别（LOW, MEDIUM, HIGH）
     */
    @Column(name = "warning_level", nullable = false, length = 20)
    private String warningLevel;

    /**
     * 预警标题
     */
    @Column(name = "title", nullable = false, length = 200)
    private String title;

    /**
     * 预警内容
     */
    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    /**
     * 当前平时分
     */
    @Column(name = "current_regular_score", precision = 5, scale = 2)
    private BigDecimal currentRegularScore;

    /**
     * 预警阈值
     */
    @Column(name = "warning_threshold", precision = 5, scale = 2)
    private BigDecimal warningThreshold;

    /**
     * 是否已处理
     */
    @Column(name = "is_handled", nullable = false)
    @Builder.Default
    private Boolean isHandled = false;

    /**
     * 处理时间
     */
    @Column(name = "handled_at")
    private LocalDateTime handledAt;

    /**
     * 处理人ID
     */
    @Column(name = "handled_by")
    private Long handledBy;

    /**
     * 处理备注
     */
    @Column(name = "handle_remarks", columnDefinition = "TEXT")
    private String handleRemarks;

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

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
