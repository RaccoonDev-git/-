package com.example.studentanalysissystem.repository;

import com.example.studentanalysissystem.model.StudentWarning;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 学生预警Repository接口
 */
@Repository
public interface StudentWarningRepository extends JpaRepository<StudentWarning, Long> {

    /**
     * 根据学生ID查找预警
     */
    List<StudentWarning> findByStudentId(Long studentId);

    /**
     * 根据课程ID查找预警
     */
    List<StudentWarning> findByCourseId(Long courseId);

    /**
     * 根据学生ID和课程ID查找预警
     */
    List<StudentWarning> findByStudentIdAndCourseId(Long studentId, Long courseId);

    /**
     * 查找未处理的预警
     */
    List<StudentWarning> findByIsHandledFalse();

    /**
     * 根据学生ID查找未处理的预警
     */
    List<StudentWarning> findByStudentIdAndIsHandledFalse(Long studentId);

    /**
     * 根据课程ID查找未处理的预警
     */
    List<StudentWarning> findByCourseIdAndIsHandledFalse(Long courseId);

    /**
     * 根据预警级别查找预警
     */
    List<StudentWarning> findByWarningLevel(String warningLevel);

    /**
     * 根据预警类型查找预警
     */
    List<StudentWarning> findByWarningType(String warningType);

    /**
     * 根据学生ID、课程ID和预警类型查找预警
     */
    List<StudentWarning> findByStudentIdAndCourseIdAndWarningType(Long studentId, Long courseId, String warningType);

    /**
     * 根据学期查找预警
     */
    List<StudentWarning> findBySemester(String semester);

    /**
     * 根据学年查找预警
     */
    List<StudentWarning> findByAcademicYear(String academicYear);

    /**
     * 查找指定时间范围内的预警
     */
    List<StudentWarning> findByCreatedAtBetween(LocalDateTime startTime, LocalDateTime endTime);

    /**
     * 统计未处理预警数量
     */
    @Query("SELECT COUNT(sw) FROM StudentWarning sw WHERE sw.isHandled = false")
    Long countUnhandledWarnings();

    /**
     * 统计学生的未处理预警数量
     */
    @Query("SELECT COUNT(sw) FROM StudentWarning sw WHERE sw.student.id = :studentId AND sw.isHandled = false")
    Long countUnhandledWarningsByStudent(@Param("studentId") Long studentId);

    /**
     * 统计课程的未处理预警数量
     */
    @Query("SELECT COUNT(sw) FROM StudentWarning sw WHERE sw.course.id = :courseId AND sw.isHandled = false")
    Long countUnhandledWarningsByCourse(@Param("courseId") Long courseId);
}
