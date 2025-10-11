package com.example.studentanalysissystem.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 课程权重配置模型
 * 用于配置每门课程的平时分和期末分权重
 */
@Entity
@Table(name = "course_weight_configs")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CourseWeightConfig {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "course_id", nullable = false, unique = true)
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler", "teacher", "enrollments", "grades" })
    private Course course;

    /**
     * 平时分权重（百分比，如30表示30%）
     */
    @Column(name = "regular_weight", nullable = false, precision = 5, scale = 2)
    private BigDecimal regularWeight;

    /**
     * 期末分权重（百分比，如70表示70%）
     */
    @Column(name = "final_weight", nullable = false, precision = 5, scale = 2)
    private BigDecimal finalWeight;

    /**
     * 补考权重（百分比，如100表示100%）
     */
    @Column(name = "makeup_weight", precision = 5, scale = 2)
    private BigDecimal makeupWeight;

    /**
     * 是否启用权重配置
     */
    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private Boolean isActive = true;

    /**
     * 配置说明
     */
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    @PreUpdate
    public void validateWeights() {
        // 验证权重总和是否为100%
        if (regularWeight != null && finalWeight != null) {
            BigDecimal total = regularWeight.add(finalWeight);
            if (total.compareTo(BigDecimal.valueOf(100)) != 0) {
                throw new IllegalArgumentException("平时分权重和期末分权重之和必须等于100%");
            }
        }

        // 设置默认补考权重为100%
        if (makeupWeight == null) {
            makeupWeight = BigDecimal.valueOf(100);
        }
    }
}
