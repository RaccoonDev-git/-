package com.example.studentanalysissystem.service.impl;

import com.example.studentanalysissystem.dto.request.CalculateComprehensiveGradeRequest;
import com.example.studentanalysissystem.dto.response.ComprehensiveGradeResponse;
import com.example.studentanalysissystem.exception.ResourceNotFoundException;
import com.example.studentanalysissystem.mapper.ComprehensiveGradeMapper;
import com.example.studentanalysissystem.model.*;
import com.example.studentanalysissystem.repository.*;
import com.example.studentanalysissystem.service.ComprehensiveGradeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 综合成绩服务实现类
 */
@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class ComprehensiveGradeServiceImpl implements ComprehensiveGradeService {

    private final ComprehensiveGradeRepository comprehensiveGradeRepository;
    private final CourseWeightConfigRepository courseWeightConfigRepository;
    private final GradeTypeRepository gradeTypeRepository;
    // private final GradeRepository gradeRepository; // 暂时注释掉未使用的字段
    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;
    private final ComprehensiveGradeMapper comprehensiveGradeMapper;

    @Override
    @Transactional
    public ComprehensiveGradeResponse calculateComprehensiveGrade(CalculateComprehensiveGradeRequest request) {
        log.info("开始计算学生{}课程{}的综合成绩", request.getStudentId(), request.getCourseId());

        // 获取学生和课程信息
        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new ResourceNotFoundException("Student", "id", request.getStudentId()));
        Course course = courseRepository.findById(request.getCourseId())
                .orElseThrow(() -> new ResourceNotFoundException("Course", "id", request.getCourseId()));

        // 获取课程权重配置
        CourseWeightConfig weightConfig = courseWeightConfigRepository
                .findByCourseIdAndIsActive(request.getCourseId(), true)
                .orElseThrow(
                        () -> new ResourceNotFoundException("CourseWeightConfig", "courseId", request.getCourseId()));

        // 计算平时分总分
        BigDecimal regularScore = calculateRegularScore(request.getRegularScores());

        // 计算综合成绩
        BigDecimal comprehensiveScore = calculateComprehensiveScore(
                regularScore, request.getFinalScore(), weightConfig);

        // 确定最终成绩
        BigDecimal finalGrade = determineFinalGrade(comprehensiveScore, request.getMakeupScore());

        // 查找或创建综合成绩记录
        ComprehensiveGrade comprehensiveGrade = comprehensiveGradeRepository
                .findByStudentIdAndCourseIdAndSemesterAndAcademicYear(
                        request.getStudentId(), request.getCourseId(),
                        request.getSemester(), request.getAcademicYear())
                .orElse(ComprehensiveGrade.builder()
                        .student(student)
                        .course(course)
                        .semester(request.getSemester())
                        .academicYear(request.getAcademicYear())
                        .build());

        // 更新成绩信息
        comprehensiveGrade.setRegularScore(regularScore);
        comprehensiveGrade.setFinalScore(request.getFinalScore());
        comprehensiveGrade.setMakeupScore(request.getMakeupScore());
        comprehensiveGrade.setComprehensiveScore(comprehensiveScore);
        comprehensiveGrade.setFinalGrade(finalGrade);
        comprehensiveGrade.setHasMakeup(request.getMakeupScore() != null);
        comprehensiveGrade.setRemarks(request.getRemarks());

        // 保存或更新
        ComprehensiveGrade savedGrade = comprehensiveGradeRepository.save(comprehensiveGrade);

        log.info("综合成绩计算完成，最终成绩：{}", finalGrade);
        return comprehensiveGradeMapper.toResponse(savedGrade, weightConfig, request.getRegularScores());
    }

    /**
     * 计算平时分总分
     */
    private BigDecimal calculateRegularScore(Map<String, BigDecimal> regularScores) {
        if (regularScores == null || regularScores.isEmpty()) {
            return BigDecimal.ZERO;
        }

        // 获取平时分类型及其权重
        List<GradeType> regularTypes = gradeTypeRepository.findByIsRegularTrueAndIsActiveTrueOrderBySortOrder();
        BigDecimal totalScore = BigDecimal.ZERO;
        BigDecimal totalWeight = BigDecimal.ZERO;

        for (GradeType gradeType : regularTypes) {
            BigDecimal score = regularScores.get(gradeType.getTypeCode());
            if (score != null && gradeType.getDefaultWeight() != null) {
                // 按权重计算加权分数
                BigDecimal weightedScore = score.multiply(gradeType.getDefaultWeight())
                        .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
                totalScore = totalScore.add(weightedScore);
                totalWeight = totalWeight.add(gradeType.getDefaultWeight());
            }
        }

        // 如果权重总和不为100%，按比例调整
        if (totalWeight.compareTo(BigDecimal.valueOf(100)) != 0 && totalWeight.compareTo(BigDecimal.ZERO) > 0) {
            totalScore = totalScore.multiply(BigDecimal.valueOf(100))
                    .divide(totalWeight, 2, RoundingMode.HALF_UP);
        }

        return totalScore;
    }

    /**
     * 计算综合成绩
     */
    private BigDecimal calculateComprehensiveScore(BigDecimal regularScore, BigDecimal finalScore,
            CourseWeightConfig weightConfig) {
        if (regularScore == null)
            regularScore = BigDecimal.ZERO;
        if (finalScore == null)
            finalScore = BigDecimal.ZERO;

        // 按权重计算综合成绩
        BigDecimal regularWeighted = regularScore.multiply(weightConfig.getRegularWeight())
                .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
        BigDecimal finalWeighted = finalScore.multiply(weightConfig.getFinalWeight())
                .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

        return regularWeighted.add(finalWeighted);
    }

    /**
     * 确定最终成绩
     */
    private BigDecimal determineFinalGrade(BigDecimal comprehensiveScore, BigDecimal makeupScore) {
        if (makeupScore != null) {
            // 如果参加了补考，使用补考成绩
            return makeupScore;
        } else {
            // 否则使用综合成绩
            return comprehensiveScore;
        }
    }

    @Override
    public List<ComprehensiveGradeResponse> getComprehensiveGradesByStudentId(Long studentId) {
        List<ComprehensiveGrade> grades = comprehensiveGradeRepository.findByStudentId(studentId);
        return grades.stream()
                .map(grade -> {
                    CourseWeightConfig weightConfig = courseWeightConfigRepository
                            .findByCourseIdAndIsActive(grade.getCourse().getId(), true)
                            .orElse(null);
                    return comprehensiveGradeMapper.toResponse(grade, weightConfig, null);
                })
                .collect(Collectors.toList());
    }

    @Override
    public List<ComprehensiveGradeResponse> getComprehensiveGradesByCourseId(Long courseId) {
        List<ComprehensiveGrade> grades = comprehensiveGradeRepository.findByCourseId(courseId);
        return grades.stream()
                .map(grade -> {
                    CourseWeightConfig weightConfig = courseWeightConfigRepository
                            .findByCourseIdAndIsActive(courseId, true)
                            .orElse(null);
                    return comprehensiveGradeMapper.toResponse(grade, weightConfig, null);
                })
                .collect(Collectors.toList());
    }

    @Override
    public ComprehensiveGradeResponse getComprehensiveGradeByStudentAndCourse(Long studentId, Long courseId) {
        ComprehensiveGrade grade = comprehensiveGradeRepository
                .findByStudentIdAndCourseId(studentId, courseId)
                .orElseThrow(() -> new ResourceNotFoundException("ComprehensiveGrade", "studentId and courseId",
                        studentId + " and " + courseId));

        CourseWeightConfig weightConfig = courseWeightConfigRepository
                .findByCourseIdAndIsActive(courseId, true)
                .orElse(null);

        return comprehensiveGradeMapper.toResponse(grade, weightConfig, null);
    }

    @Override
    @Transactional
    public List<ComprehensiveGradeResponse> batchCalculateComprehensiveGrades(Long courseId) {
        // 获取课程的所有学生
        List<Student> students = studentRepository.findByCourseId(courseId);

        return students.stream()
                .map(student -> {
                    // 获取学生的平时分和期末分
                    Map<String, BigDecimal> regularScores = getStudentRegularScores(student.getId(), courseId);
                    BigDecimal finalScore = getStudentFinalScore(student.getId(), courseId);

                    CalculateComprehensiveGradeRequest request = CalculateComprehensiveGradeRequest.builder()
                            .studentId(student.getId())
                            .courseId(courseId)
                            .regularScores(regularScores)
                            .finalScore(finalScore)
                            .build();

                    return calculateComprehensiveGrade(request);
                })
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void recalculateAllComprehensiveGrades() {
        // 获取所有课程
        List<Course> courses = courseRepository.findAll();

        for (Course course : courses) {
            batchCalculateComprehensiveGrades(course.getId());
        }
    }

    @Override
    @Transactional
    public ComprehensiveGradeResponse updateMakeupScore(Long studentId, Long courseId, Double makeupScore) {
        ComprehensiveGrade grade = comprehensiveGradeRepository
                .findByStudentIdAndCourseId(studentId, courseId)
                .orElseThrow(() -> new ResourceNotFoundException("ComprehensiveGrade", "studentId and courseId",
                        studentId + " and " + courseId));

        grade.setMakeupScore(BigDecimal.valueOf(makeupScore));
        grade.setHasMakeup(true);

        ComprehensiveGrade savedGrade = comprehensiveGradeRepository.save(grade);

        CourseWeightConfig weightConfig = courseWeightConfigRepository
                .findByCourseIdAndIsActive(courseId, true)
                .orElse(null);

        return comprehensiveGradeMapper.toResponse(savedGrade, weightConfig, null);
    }

    @Override
    public Object getStudentGradeStatistics(Long studentId) {
        // 实现学生成绩统计逻辑
        return null;
    }

    @Override
    public Object getCourseGradeStatistics(Long courseId) {
        // 实现课程成绩统计逻辑
        return null;
    }

    /**
     * 获取学生平时分各类型成绩
     */
    private Map<String, BigDecimal> getStudentRegularScores(Long studentId, Long courseId) {
        // 实现获取学生平时分逻辑
        return null;
    }

    /**
     * 获取学生期末分
     */
    private BigDecimal getStudentFinalScore(Long studentId, Long courseId) {
        // 实现获取学生期末分逻辑
        return null;
    }
}
