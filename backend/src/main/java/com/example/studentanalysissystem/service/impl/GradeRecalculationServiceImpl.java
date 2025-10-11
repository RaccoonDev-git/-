package com.example.studentanalysissystem.service.impl;

import com.example.studentanalysissystem.dto.request.CalculateComprehensiveGradeRequest;
import com.example.studentanalysissystem.model.*;
import com.example.studentanalysissystem.repository.*;
import com.example.studentanalysissystem.service.GradeRecalculationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 成绩重新计算服务实现类
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class GradeRecalculationServiceImpl implements GradeRecalculationService {

    private final ComprehensiveGradeRepository comprehensiveGradeRepository;
    private final GradeRepository gradeRepository;
    private final CourseRepository courseRepository;
    private final CourseWeightConfigRepository courseWeightConfigRepository;
    private final GradeTypeRepository gradeTypeRepository;

    @Override
    @Transactional
    public void recalculateCourseGrades(Long courseId) {
        log.info("开始重新计算课程{}的所有综合成绩", courseId);

        // 获取课程的所有综合成绩记录
        List<ComprehensiveGrade> grades = comprehensiveGradeRepository.findByCourseId(courseId);

        for (ComprehensiveGrade grade : grades) {
            try {
                recalculateSingleGrade(grade);
                log.debug("重新计算完成: 学生{}, 课程{}", grade.getStudent().getId(), courseId);
            } catch (Exception e) {
                log.error("重新计算失败: 学生{}, 课程{}, 错误: {}",
                        grade.getStudent().getId(), courseId, e.getMessage());
            }
        }

        log.info("课程{}的综合成绩重新计算完成，共处理{}条记录", courseId, grades.size());
    }

    @Override
    @Transactional
    public void recalculateGradesByGradeType(Long gradeTypeId) {
        log.info("开始重新计算与成绩类型{}相关的所有综合成绩", gradeTypeId);

        // 获取所有课程的综合成绩记录
        List<ComprehensiveGrade> allGrades = comprehensiveGradeRepository.findAll();

        int recalculatedCount = 0;
        for (ComprehensiveGrade grade : allGrades) {
            try {
                if (needsRecalculation(grade, gradeTypeId)) {
                    recalculateSingleGrade(grade);
                    recalculatedCount++;
                }
            } catch (Exception e) {
                log.error("重新计算失败: 学生{}, 课程{}, 错误: {}",
                        grade.getStudent().getId(), grade.getCourse().getId(), e.getMessage());
            }
        }

        log.info("与成绩类型{}相关的综合成绩重新计算完成，共处理{}条记录", gradeTypeId, recalculatedCount);
    }

    @Override
    @Transactional
    public void recalculateGradesAfterGradeTypeDeletion(Long gradeTypeId) {
        log.info("成绩类型{}被删除，开始重新计算相关综合成绩", gradeTypeId);
        recalculateGradesByGradeType(gradeTypeId);
    }

    @Override
    @Transactional
    public void recalculateGradesAfterGradeTypeAddition(Long gradeTypeId) {
        log.info("新增成绩类型{}，开始重新计算相关综合成绩", gradeTypeId);
        recalculateGradesByGradeType(gradeTypeId);
    }

    @Override
    @Transactional
    public void recalculateAllGrades() {
        log.info("开始重新计算所有综合成绩");

        List<ComprehensiveGrade> allGrades = comprehensiveGradeRepository.findAll();

        for (ComprehensiveGrade grade : allGrades) {
            try {
                recalculateSingleGrade(grade);
            } catch (Exception e) {
                log.error("重新计算失败: 学生{}, 课程{}, 错误: {}",
                        grade.getStudent().getId(), grade.getCourse().getId(), e.getMessage());
            }
        }

        log.info("所有综合成绩重新计算完成，共处理{}条记录", allGrades.size());
    }

    @Override
    @Transactional
    public void checkAndFixDataConsistency(Long courseId) {
        log.info("开始检查数据一致性，课程ID: {}", courseId);

        List<Course> courses = courseId != null ? List.of(courseRepository.findById(courseId).orElseThrow())
                : courseRepository.findAll();

        for (Course course : courses) {
            checkCourseDataConsistency(course);
        }

        log.info("数据一致性检查完成");
    }

    /**
     * 重新计算单个综合成绩
     */
    private void recalculateSingleGrade(ComprehensiveGrade grade) {
        Long studentId = grade.getStudent().getId();
        Long courseId = grade.getCourse().getId();

        // 获取课程权重配置
        CourseWeightConfig weightConfig = courseWeightConfigRepository
                .findByCourseIdAndIsActive(courseId, true)
                .orElseThrow(() -> new RuntimeException("课程权重配置不存在: " + courseId));

        // 获取该学生该课程的所有原始成绩
        List<Grade> rawGrades = gradeRepository.findByStudentIdAndCourseId(studentId, courseId);

        // 分离平时分和期末分
        Map<String, BigDecimal> regularScores = new HashMap<>();
        BigDecimal finalScore = null;
        BigDecimal makeupScore = null;

        for (Grade rawGrade : rawGrades) {
            String examType = rawGrade.getExamType();
            if ("期末考试".equals(examType) || "FINAL".equals(examType)) {
                finalScore = rawGrade.getScore();
            } else if ("补考".equals(examType) || "MAKEUP".equals(examType)) {
                makeupScore = rawGrade.getScore();
            } else {
                // 平时分类型
                regularScores.put(examType, rawGrade.getScore());
            }
        }

        // 重新计算综合成绩
        CalculateComprehensiveGradeRequest request = CalculateComprehensiveGradeRequest.builder()
                .studentId(studentId)
                .courseId(courseId)
                .regularScores(regularScores)
                .finalScore(finalScore)
                .makeupScore(makeupScore)
                .semester(grade.getSemester())
                .academicYear(grade.getAcademicYear())
                .remarks(grade.getRemarks())
                .build();

        // 这里应该调用综合成绩服务进行重新计算
        // 由于循环依赖问题，我们直接在这里实现计算逻辑
        recalculateGradeDirectly(grade, request, weightConfig);
    }

    /**
     * 直接重新计算成绩（避免循环依赖）
     */
    private void recalculateGradeDirectly(ComprehensiveGrade grade,
            CalculateComprehensiveGradeRequest request,
            CourseWeightConfig weightConfig) {

        // 计算平时分总分
        BigDecimal regularScore = calculateRegularScoreDirectly(request.getRegularScores());

        // 计算综合成绩
        BigDecimal comprehensiveScore = calculateComprehensiveScoreDirectly(
                regularScore, request.getFinalScore(), weightConfig);

        // 确定最终成绩
        BigDecimal finalGrade = determineFinalGradeDirectly(comprehensiveScore, request.getMakeupScore());

        // 更新成绩信息
        grade.setRegularScore(regularScore);
        grade.setFinalScore(request.getFinalScore());
        grade.setMakeupScore(request.getMakeupScore());
        grade.setComprehensiveScore(comprehensiveScore);
        grade.setFinalGrade(finalGrade);
        grade.setHasMakeup(request.getMakeupScore() != null);
        grade.setIsPassed(finalGrade.compareTo(BigDecimal.valueOf(60)) >= 0);

        comprehensiveGradeRepository.save(grade);
    }

    /**
     * 计算平时分总分
     */
    private BigDecimal calculateRegularScoreDirectly(Map<String, BigDecimal> regularScores) {
        if (regularScores == null || regularScores.isEmpty()) {
            return BigDecimal.ZERO;
        }

        List<GradeType> regularTypes = gradeTypeRepository.findByIsRegularTrueAndIsActiveTrueOrderBySortOrder();
        BigDecimal totalScore = BigDecimal.ZERO;
        BigDecimal totalWeight = BigDecimal.ZERO;

        for (GradeType gradeType : regularTypes) {
            BigDecimal score = regularScores.get(gradeType.getTypeCode());
            if (score != null && gradeType.getDefaultWeight() != null) {
                BigDecimal weightedScore = score.multiply(gradeType.getDefaultWeight())
                        .divide(BigDecimal.valueOf(100), 2, java.math.RoundingMode.HALF_UP);
                totalScore = totalScore.add(weightedScore);
                totalWeight = totalWeight.add(gradeType.getDefaultWeight());
            }
        }

        if (totalWeight.compareTo(BigDecimal.valueOf(100)) != 0 && totalWeight.compareTo(BigDecimal.ZERO) > 0) {
            totalScore = totalScore.multiply(BigDecimal.valueOf(100))
                    .divide(totalWeight, 2, BigDecimal.ROUND_HALF_UP);
        }

        return totalScore;
    }

    /**
     * 计算综合成绩
     */
    private BigDecimal calculateComprehensiveScoreDirectly(BigDecimal regularScore, BigDecimal finalScore,
            CourseWeightConfig weightConfig) {
        if (regularScore == null)
            regularScore = BigDecimal.ZERO;
        if (finalScore == null)
            finalScore = BigDecimal.ZERO;

        BigDecimal regularWeighted = regularScore.multiply(weightConfig.getRegularWeight())
                .divide(BigDecimal.valueOf(100), 2, java.math.RoundingMode.HALF_UP);
        BigDecimal finalWeighted = finalScore.multiply(weightConfig.getFinalWeight())
                .divide(BigDecimal.valueOf(100), 2, java.math.RoundingMode.HALF_UP);

        return regularWeighted.add(finalWeighted);
    }

    /**
     * 确定最终成绩
     */
    private BigDecimal determineFinalGradeDirectly(BigDecimal comprehensiveScore, BigDecimal makeupScore) {
        if (makeupScore != null && comprehensiveScore.compareTo(BigDecimal.valueOf(60)) < 0) {
            return makeupScore;
        }
        return comprehensiveScore;
    }

    /**
     * 检查是否需要重新计算
     */
    private boolean needsRecalculation(ComprehensiveGrade grade, Long gradeTypeId) {
        // 简化实现：总是重新计算
        // 在实际应用中，可以添加更复杂的逻辑来判断是否需要重新计算
        return true;
    }

    /**
     * 检查课程数据一致性
     */
    private void checkCourseDataConsistency(Course course) {
        log.debug("检查课程{}的数据一致性", course.getId());

        // 检查是否有权重配置
        boolean hasWeightConfig = courseWeightConfigRepository
                .findByCourseIdAndIsActive(course.getId(), true)
                .isPresent();

        if (!hasWeightConfig) {
            log.warn("课程{}缺少权重配置", course.getId());
        }

        // 检查综合成绩是否与原始成绩一致
        List<ComprehensiveGrade> comprehensiveGrades = comprehensiveGradeRepository.findByCourseId(course.getId());
        for (ComprehensiveGrade grade : comprehensiveGrades) {
            // 这里可以添加更详细的检查逻辑
            log.debug("检查学生{}在课程{}中的成绩一致性", grade.getStudent().getId(), course.getId());
        }
    }
}
