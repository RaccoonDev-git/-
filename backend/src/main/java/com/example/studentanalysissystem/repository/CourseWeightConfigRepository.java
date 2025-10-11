package com.example.studentanalysissystem.repository;

import com.example.studentanalysissystem.model.CourseWeightConfig;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * 课程权重配置Repository接口
 */
@Repository
public interface CourseWeightConfigRepository extends JpaRepository<CourseWeightConfig, Long> {

    /**
     * 根据课程ID查找权重配置
     */
    Optional<CourseWeightConfig> findByCourseId(Long courseId);

    /**
     * 根据课程ID和是否启用查找权重配置
     */
    Optional<CourseWeightConfig> findByCourseIdAndIsActive(Long courseId, Boolean isActive);

    /**
     * 查找所有启用的权重配置
     */
    List<CourseWeightConfig> findByIsActiveTrue();

    /**
     * 根据课程ID列表查找权重配置
     */
    @Query("SELECT cwc FROM CourseWeightConfig cwc WHERE cwc.course.id IN :courseIds AND cwc.isActive = true")
    List<CourseWeightConfig> findByCourseIdInAndIsActiveTrue(@Param("courseIds") List<Long> courseIds);

    /**
     * 使用原生SQL创建或更新权重配置，避免序列化问题
     */
    @Modifying
    @Query(value = """
            INSERT INTO course_weight_configs (course_id, regular_weight, final_weight, makeup_weight, is_active, created_at, updated_at)
            VALUES (:courseId, :regularWeight, :finalWeight, :makeupWeight, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
            ON DUPLICATE KEY UPDATE
            regular_weight = VALUES(regular_weight),
            final_weight = VALUES(final_weight),
            makeup_weight = VALUES(makeup_weight),
            updated_at = CURRENT_TIMESTAMP
            """, nativeQuery = true)
    int upsertWeightConfig(@Param("courseId") Long courseId,
            @Param("regularWeight") BigDecimal regularWeight,
            @Param("finalWeight") BigDecimal finalWeight,
            @Param("makeupWeight") BigDecimal makeupWeight);

    /**
     * 使用原生SQL获取权重配置，返回Map避免序列化问题
     */
    @Query(value = """
            SELECT
                cwc.id,
                cwc.course_id as courseId,
                c.name as courseName,
                c.code as courseCode,
                cwc.regular_weight as regularWeight,
                cwc.final_weight as finalWeight,
                cwc.makeup_weight as makeupWeight,
                cwc.is_active as isActive,
                cwc.description,
                cwc.created_at as createdAt,
                cwc.updated_at as updatedAt
            FROM course_weight_configs cwc
            JOIN courses c ON cwc.course_id = c.id
            WHERE cwc.course_id = :courseId AND cwc.is_active = true
            """, nativeQuery = true)
    Map<String, Object> findWeightConfigByCourseIdNative(@Param("courseId") Long courseId);

    /**
     * 使用原生SQL获取所有权重配置，返回Map列表避免序列化问题
     */
    @Query(value = """
            SELECT
                cwc.id,
                cwc.course_id as courseId,
                c.name as courseName,
                c.code as courseCode,
                cwc.regular_weight as regularWeight,
                cwc.final_weight as finalWeight,
                cwc.makeup_weight as makeupWeight,
                cwc.is_active as isActive,
                cwc.description,
                cwc.created_at as createdAt,
                cwc.updated_at as updatedAt
            FROM course_weight_configs cwc
            JOIN courses c ON cwc.course_id = c.id
            WHERE cwc.is_active = true
            ORDER BY cwc.created_at DESC
            """, nativeQuery = true)
    List<Map<String, Object>> findAllWeightConfigsNative();

    /**
     * 使用原生SQL检查课程是否存在
     */
    @Query(value = "SELECT COUNT(*) FROM courses WHERE id = :courseId", nativeQuery = true)
    int checkCourseExists(@Param("courseId") Long courseId);
}
