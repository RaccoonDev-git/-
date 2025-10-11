package com.example.studentanalysissystem.repository;

import com.example.studentanalysissystem.model.ComprehensiveGrade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * 综合成绩Repository接口
 */
@Repository
public interface ComprehensiveGradeRepository extends JpaRepository<ComprehensiveGrade, Long> {

    /**
     * 根据学生ID查找综合成绩
     */
    List<ComprehensiveGrade> findByStudentId(Long studentId);

    /**
     * 根据课程ID查找综合成绩
     */
    List<ComprehensiveGrade> findByCourseId(Long courseId);

    /**
     * 根据学生ID和课程ID查找综合成绩
     */
    Optional<ComprehensiveGrade> findByStudentIdAndCourseId(Long studentId, Long courseId);

    /**
     * 根据学生ID、课程ID、学期和学年查找综合成绩
     */
    Optional<ComprehensiveGrade> findByStudentIdAndCourseIdAndSemesterAndAcademicYear(
            Long studentId, Long courseId, String semester, String academicYear);

    /**
     * 查找学生的所有通过成绩
     */
    List<ComprehensiveGrade> findByStudentIdAndIsPassedTrue(Long studentId);

    /**
     * 查找学生的所有未通过成绩
     */
    List<ComprehensiveGrade> findByStudentIdAndIsPassedFalse(Long studentId);

    /**
     * 查找课程的所有通过成绩
     */
    List<ComprehensiveGrade> findByCourseIdAndIsPassedTrue(Long courseId);

    /**
     * 查找课程的所有未通过成绩
     */
    List<ComprehensiveGrade> findByCourseIdAndIsPassedFalse(Long courseId);

    /**
     * 查找参加补考的学生成绩
     */
    List<ComprehensiveGrade> findByStudentIdAndHasMakeupTrue(Long studentId);

    /**
     * 根据学期查找综合成绩
     */
    List<ComprehensiveGrade> findBySemester(String semester);

    /**
     * 根据学年查找综合成绩
     */
    List<ComprehensiveGrade> findByAcademicYear(String academicYear);

    /**
     * 计算学生的平均综合成绩
     */
    @Query("SELECT AVG(cg.finalGrade) FROM ComprehensiveGrade cg WHERE cg.student.id = :studentId")
    BigDecimal calculateAverageFinalGradeByStudent(@Param("studentId") Long studentId);

    /**
     * 计算课程的平均综合成绩
     */
    @Query("SELECT AVG(cg.finalGrade) FROM ComprehensiveGrade cg WHERE cg.course.id = :courseId")
    BigDecimal calculateAverageFinalGradeByCourse(@Param("courseId") Long courseId);

    /**
     * 统计通过率
     */
    @Query("SELECT COUNT(CASE WHEN cg.isPassed = true THEN 1 END) * 100.0 / COUNT(*) FROM ComprehensiveGrade cg WHERE cg.course.id = :courseId")
    BigDecimal calculatePassRateByCourse(@Param("courseId") Long courseId);
}
