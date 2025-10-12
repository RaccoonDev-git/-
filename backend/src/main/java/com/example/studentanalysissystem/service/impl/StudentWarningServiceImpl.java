package com.example.studentanalysissystem.service.impl;

import com.example.studentanalysissystem.dto.response.StudentWarningResponse;
import com.example.studentanalysissystem.exception.ResourceNotFoundException;
// import com.example.studentanalysissystem.mapper.StudentWarningMapper; // 暂时注释掉
import com.example.studentanalysissystem.model.*;
import com.example.studentanalysissystem.repository.*;
import com.example.studentanalysissystem.service.StudentWarningService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 学生预警服务实现类
 */
@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class StudentWarningServiceImpl implements StudentWarningService {

    private final StudentWarningRepository studentWarningRepository;
    private final ComprehensiveGradeRepository comprehensiveGradeRepository;
    private final CourseWeightConfigRepository courseWeightConfigRepository;
    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;
    // private final StudentWarningMapper studentWarningMapper; // 暂时注释掉

    // 预警阈值配置
    private static final BigDecimal LOW_REGULAR_SCORE_THRESHOLD = BigDecimal.valueOf(60); // 平时分低于60分
    private static final BigDecimal MEDIUM_REGULAR_SCORE_THRESHOLD = BigDecimal.valueOf(70); // 平时分低于70分
    private static final BigDecimal HIGH_REGULAR_SCORE_THRESHOLD = BigDecimal.valueOf(50); // 平时分低于50分

    @Override
    @Transactional
    public void checkAndGenerateWarnings(Long courseId) {
        log.info("开始检查课程{}的学生预警", courseId);

        // 获取课程信息
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course", "id", courseId));

        // 获取课程的所有学生（通过选课关系）
        List<Student> students = studentRepository.findByCourseId(courseId);

        for (Student student : students) {
            // 获取学生的综合成绩（可能有多个记录，取最新的）
            List<ComprehensiveGrade> grades = comprehensiveGradeRepository
                    .findAllByStudentIdAndCourseId(student.getId(), courseId);

            if (grades == null || grades.isEmpty()) {
                continue;
            }

            // 取最新的综合成绩记录（按创建时间排序）
            ComprehensiveGrade grade = grades.stream()
                    .filter(g -> g.getRegularScore() != null)
                    .max((g1, g2) -> {
                        if (g1.getCreatedAt() == null && g2.getCreatedAt() == null) return 0;
                        if (g1.getCreatedAt() == null) return -1;
                        if (g2.getCreatedAt() == null) return 1;
                        return g1.getCreatedAt().compareTo(g2.getCreatedAt());
                    })
                    .orElse(null);

            if (grade == null) {
                continue;
            }

            // 检查平时分预警
            checkRegularScoreWarning(student, course, grade);
        }

        log.info("课程{}的学生预警检查完成", courseId);
    }

    @Override
    @Transactional
    public void checkAndGenerateAllWarnings() {
        log.info("开始检查所有课程的学生预警");

        List<Course> courses = courseRepository.findAll();
        for (Course course : courses) {
            checkAndGenerateWarnings(course.getId());
        }

        log.info("所有课程的学生预警检查完成");
    }

    /**
     * 检查平时分预警
     */
    private void checkRegularScoreWarning(Student student, Course course, ComprehensiveGrade grade) {
        BigDecimal regularScore = grade.getRegularScore();
        String warningType = "LOW_REGULAR_SCORE";
        String warningLevel = "LOW";
        String title = "平时分偏低提醒";
        String content = String.format("学生%s在课程%s中的平时分为%.2f分，请注意提高平时表现。",
                student.getName(), course.getName(), regularScore);

        // 根据平时分确定预警级别
        if (regularScore.compareTo(HIGH_REGULAR_SCORE_THRESHOLD) < 0) {
            warningLevel = "HIGH";
            title = "平时分严重偏低警告";
            content = String.format("学生%s在课程%s中的平时分为%.2f分，严重偏低，请立即关注！",
                    student.getName(), course.getName(), regularScore);
        } else if (regularScore.compareTo(MEDIUM_REGULAR_SCORE_THRESHOLD) < 0) {
            warningLevel = "MEDIUM";
            title = "平时分偏低提醒";
            content = String.format("学生%s在课程%s中的平时分为%.2f分，偏低，建议关注。",
                    student.getName(), course.getName(), regularScore);
        }

        // 检查是否已存在相同的预警
        boolean existsWarning = studentWarningRepository
                .findByStudentIdAndCourseIdAndWarningType(student.getId(), course.getId(), warningType)
                .stream()
                .anyMatch(warning -> !warning.getIsHandled());

        if (!existsWarning) {
            // 创建预警
            StudentWarning warning = StudentWarning.builder()
                    .student(student)
                    .course(course)
                    .warningType(warningType)
                    .warningLevel(warningLevel)
                    .title(title)
                    .content(content)
                    .currentRegularScore(regularScore)
                    .warningThreshold(LOW_REGULAR_SCORE_THRESHOLD)
                    .semester(grade.getSemester())
                    .academicYear(grade.getAcademicYear())
                    .build();

            studentWarningRepository.save(warning);
            log.info("为学生{}课程{}创建了{}级预警", student.getName(), course.getName(), warningLevel);
        }
    }

    @Override
    public List<StudentWarningResponse> getWarningsByStudentId(Long studentId) {
        List<StudentWarning> warnings = studentWarningRepository.findByStudentId(studentId);
        return warnings.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<StudentWarningResponse> getWarningsByCourseId(Long courseId) {
        List<StudentWarning> warnings = studentWarningRepository.findByCourseId(courseId);
        return warnings.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<StudentWarningResponse> getAllWarnings() {
        List<StudentWarning> warnings = studentWarningRepository.findAll();
        return warnings.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<StudentWarningResponse> getUnhandledWarnings() {
        List<StudentWarning> warnings = studentWarningRepository.findByIsHandledFalse();
        return warnings.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void handleWarning(Long warningId, Long handledBy, String handleRemarks) {
        StudentWarning warning = studentWarningRepository.findById(warningId)
                .orElseThrow(() -> new ResourceNotFoundException("StudentWarning", "id", warningId));

        warning.setIsHandled(true);
        warning.setHandledAt(LocalDateTime.now());
        warning.setHandledBy(handledBy);
        warning.setHandleRemarks(handleRemarks);

        studentWarningRepository.save(warning);
        log.info("预警{}已处理", warningId);
    }

    @Override
    @Transactional
    public void batchHandleWarnings(List<Long> warningIds, Long handledBy, String handleRemarks) {
        for (Long warningId : warningIds) {
            handleWarning(warningId, handledBy, handleRemarks);
        }
        log.info("批量处理了{}个预警", warningIds.size());
    }

    @Override
    @Transactional
    public void deleteWarning(Long warningId) {
        if (!studentWarningRepository.existsById(warningId)) {
            throw new ResourceNotFoundException("StudentWarning", "id", warningId);
        }
        studentWarningRepository.deleteById(warningId);
        log.info("预警{}已删除", warningId);
    }

    @Override
    public Object getWarningStatistics() {
        // 实现预警统计逻辑
        return null;
    }

    /**
     * 转换为响应DTO
     */
    private StudentWarningResponse toResponse(StudentWarning warning) {
        if (warning == null) {
            return null;
        }

        return StudentWarningResponse.builder()
                .id(warning.getId())
                .studentId(warning.getStudent().getId())
                .studentName(warning.getStudent().getName())
                .studentNumber(warning.getStudent().getStudentNumber())
                .courseId(warning.getCourse().getId())
                .courseCode(warning.getCourse().getCode())
                .courseName(warning.getCourse().getName())
                .warningType(warning.getWarningType())
                .warningLevel(warning.getWarningLevel())
                .title(warning.getTitle())
                .content(warning.getContent())
                .currentRegularScore(warning.getCurrentRegularScore())
                .warningThreshold(warning.getWarningThreshold())
                .isHandled(warning.getIsHandled())
                .handledAt(warning.getHandledAt())
                .handledBy(warning.getHandledBy())
                .handleRemarks(warning.getHandleRemarks())
                .semester(warning.getSemester())
                .academicYear(warning.getAcademicYear())
                .createdAt(warning.getCreatedAt())
                .updatedAt(warning.getUpdatedAt())
                .build();
    }
}
