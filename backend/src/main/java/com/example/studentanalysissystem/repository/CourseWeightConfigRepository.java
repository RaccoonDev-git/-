package com.example.studentanalysissystem.repository;

import com.example.studentanalysissystem.model.CourseWeightConfig;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
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
}
