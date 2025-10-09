package com.example.studentanalysissystem.service;

import com.example.studentanalysissystem.dto.response.StudentWarningResponse;
import com.example.studentanalysissystem.model.Grade;
import com.example.studentanalysissystem.model.LearningActivity;
import com.example.studentanalysissystem.model.Student;
import com.example.studentanalysissystem.repository.GradeRepository;
import com.example.studentanalysissystem.repository.LearningActivityRepository;
import com.example.studentanalysissystem.repository.StudentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 学生预警系统服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class StudentWarningService {

    private final StudentRepository studentRepository;
    private final GradeRepository gradeRepository;
    private final LearningActivityRepository learningActivityRepository;

    /**
     * 获取学生预警列表
     * 
     * @param className    可选的班级名称筛选
     * @param major        可选的专业筛选
     * @param warningLevel 可选的预警级别筛选（high/medium/low）
     * @return 学生预警列表
     */
    public List<StudentWarningResponse> getStudentWarnings(String className, String major, String warningLevel) {
        log.info("开始生成学生预警列表: className={}, major={}, warningLevel={}", className, major, warningLevel);

        // 获取学生列表
        List<Student> students;
        if (className != null && !className.isEmpty()) {
            students = studentRepository.findByClassName(className);
        } else if (major != null && !major.isEmpty()) {
            students = studentRepository.findByMajor(major);
        } else {
            students = studentRepository.findAll();
        }

        if (students.isEmpty()) {
            log.warn("没有找到符合条件的学生");
            return new ArrayList<>();
        }

        // 为每个学生生成预警信息
        List<StudentWarningResponse> warnings = new ArrayList<>();

        for (Student student : students) {
            StudentWarningResponse warning = analyzeStudentWarning(student);

            // 根据预警级别筛选
            if (warningLevel != null && !warningLevel.isEmpty()) {
                if (warningLevel.equalsIgnoreCase(warning.getWarningLevel())) {
                    warnings.add(warning);
                }
            } else {
                // 只添加有预警的学生
                if (!"none".equalsIgnoreCase(warning.getWarningLevel())) {
                    warnings.add(warning);
                }
            }
        }

        // 按预警级别排序（high > medium > low）
        warnings.sort((w1, w2) -> {
            int priority1 = getWarningPriority(w1.getWarningLevel());
            int priority2 = getWarningPriority(w2.getWarningLevel());
            return Integer.compare(priority2, priority1); // 降序
        });

        log.info("生成了 {} 条学生预警", warnings.size());
        return warnings;
    }

    /**
     * 分析单个学生的预警情况
     */
    private StudentWarningResponse analyzeStudentWarning(Student student) {
        List<String> warningReasons = new ArrayList<>();
        List<String> suggestions = new ArrayList<>();
        String warningLevel = "none"; // none/low/medium/high

        // 初始化统计变量
        int failedCount = 0;
        double averageScore = 0.0;
        double scoreChange = 0.0;
        int recentActivityCount = 0;

        // 获取学生成绩
        List<Grade> grades = gradeRepository.findByStudentId(student.getId());

        if (grades.isEmpty()) {
            warningReasons.add("尚无成绩记录");
            suggestions.add("请及时参加课程学习和考试");
            warningLevel = "low";
        } else {
            // 1. 检查不及格情况
            List<Grade> failedGrades = grades.stream()
                    .filter(g -> g.getScore().doubleValue() < 60)
                    .collect(Collectors.toList());

            failedCount = failedGrades.size();

            if (!failedGrades.isEmpty()) {
                double failedRate = (double) failedCount / grades.size() * 100;

                if (failedCount >= 3 || failedRate >= 30) {
                    warningReasons.add(String.format("有%d门课程不及格（%.1f%%），存在挂科风险",
                            failedCount, failedRate));
                    warningLevel = "high";
                    suggestions.add("请及时与导师沟通，制定补习计划");
                    suggestions.add("建议参加学校的学业辅导项目");
                } else if (failedCount > 0) {
                    warningReasons.add(String.format("有%d门课程不及格", failedCount));
                    warningLevel = updateWarningLevel(warningLevel, "medium");
                    suggestions.add("请重点复习不及格科目，争取补考通过");
                }

                // 列出不及格科目
                String failedCourses = failedGrades.stream()
                        .map(g -> g.getCourse().getName())
                        .limit(3)
                        .collect(Collectors.joining("、"));
                if (failedCount <= 3) {
                    suggestions.add(String.format("不及格科目：%s", failedCourses));
                } else {
                    suggestions.add(String.format("不及格科目包括：%s等", failedCourses));
                }
            }

            // 2. 检查成绩下降趋势
            Map<String, Double> semesterAverages = calculateSemesterAverages(grades);
            if (semesterAverages.size() >= 2) {
                List<String> semesters = new ArrayList<>(semesterAverages.keySet());
                Collections.sort(semesters);

                if (semesters.size() >= 2) {
                    String recentSemester = semesters.get(semesters.size() - 1);
                    String previousSemester = semesters.get(semesters.size() - 2);

                    double recentAvg = semesterAverages.get(recentSemester);
                    double previousAvg = semesterAverages.get(previousSemester);
                    double decline = previousAvg - recentAvg;
                    scoreChange = -decline; // 负数表示下降，正数表示上升

                    if (decline >= 10) {
                        warningReasons.add(String.format("最近学期成绩下降明显（下降%.1f分）", decline));
                        warningLevel = updateWarningLevel(warningLevel, "medium");
                        suggestions.add("请分析成绩下降原因，调整学习方法");
                    }
                }
            }

            // 3. 检查平均分过低
            averageScore = grades.stream()
                    .mapToDouble(g -> g.getScore().doubleValue())
                    .average()
                    .orElse(0.0);

            if (averageScore < 60) {
                warningReasons.add(String.format("总体平均分过低（%.1f分），低于及格线", averageScore));
                warningLevel = "high";
                suggestions.add("学业严重落后，建议申请学业指导");
            } else if (averageScore < 70) {
                warningReasons.add(String.format("总体平均分较低（%.1f分）", averageScore));
                warningLevel = updateWarningLevel(warningLevel, "medium");
                suggestions.add("建议加强学习，提高整体成绩");
            }
        }

        // 4. 检查学习活动异常
        Optional<LearningActivity> lastActivity = learningActivityRepository
                .findTop1ByStudentIdOrderByCreatedAtDesc(student.getId());

        Date lastLoginDateValue = null;
        Long daysSinceLastLoginValue = null;

        if (lastActivity.isPresent()) {
            LocalDateTime lastLoginDateTime = lastActivity.get().getCreatedAt();
            lastLoginDateValue = Date.from(lastLoginDateTime.atZone(ZoneId.systemDefault()).toInstant());
            LocalDate lastLogin = lastLoginDateTime.toLocalDate();
            LocalDate now = LocalDate.now();
            long daysSinceLastLogin = ChronoUnit.DAYS.between(lastLogin, now);
            daysSinceLastLoginValue = daysSinceLastLogin;

            if (daysSinceLastLogin > 30) {
                warningReasons.add(String.format("已%d天未登录系统", daysSinceLastLogin));
                warningLevel = updateWarningLevel(warningLevel, "medium");
                suggestions.add("请保持学习活跃度，定期登录系统查看学习资料");
            } else if (daysSinceLastLogin > 14) {
                warningReasons.add(String.format("已%d天未登录系统", daysSinceLastLogin));
                warningLevel = updateWarningLevel(warningLevel, "low");
                suggestions.add("建议增加登录频率，及时了解课程动态");
            }
        } else {
            warningReasons.add("从未登录过系统");
            warningLevel = updateWarningLevel(warningLevel, "low");
            suggestions.add("请尽快登录系统，开始学习");
        }

        // 5. 检查学习活动频率
        LocalDateTime thirtyDaysAgo = LocalDateTime.now().minusDays(30);

        List<LearningActivity> recentActivities = learningActivityRepository
                .findByStudentIdAndCreatedAtAfter(
                        student.getId(),
                        thirtyDaysAgo);

        recentActivityCount = recentActivities.size();

        if (recentActivityCount < 5 && !grades.isEmpty()) {
            warningReasons.add("近30天学习活动较少");
            warningLevel = updateWarningLevel(warningLevel, "low");
            suggestions.add("建议增加学习时间，多参与课程活动");
        }

        // 如果没有任何预警
        if (warningReasons.isEmpty()) {
            warningReasons.add("学习状态良好");
            suggestions.add("继续保持");
        }

        // 计算优先级（用于排序）
        int priority = 3; // 默认较低
        if ("high".equals(warningLevel)) {
            priority = 1; // 最高
        } else if ("medium".equals(warningLevel)) {
            priority = 2; // 中等
        }

        return StudentWarningResponse.builder()
                .studentId(student.getId())
                .studentName(student.getName())
                .studentNumber(student.getStudentNumber())
                .className(student.getClassName())
                .major(student.getMajor())
                .warningLevel(warningLevel)
                .warningMessages(warningReasons)
                .suggestions(suggestions)
                .failedCourseCount(failedCount)
                .totalCourseCount(grades.size())
                .averageScore(averageScore)
                .scoreChange(scoreChange)
                .lastLoginDate(lastLoginDateValue)
                .daysSinceLastLogin(daysSinceLastLoginValue)
                .recentActivityCount(recentActivityCount)
                .priority(priority)
                .build();
    }

    /**
     * 计算每个学期的平均分
     */
    private Map<String, Double> calculateSemesterAverages(List<Grade> grades) {
        Map<String, List<Double>> semesterScores = new HashMap<>();

        for (Grade grade : grades) {
            // Grade模型没有semester字段，通过课程的semester字段获取
            String semester = grade.getCourse() != null ? grade.getCourse().getSemester() : null;
            if (semester != null && !semester.isEmpty()) {
                semesterScores.computeIfAbsent(semester, k -> new ArrayList<>())
                        .add(grade.getScore().doubleValue());
            }
        }

        Map<String, Double> semesterAverages = new HashMap<>();
        for (Map.Entry<String, List<Double>> entry : semesterScores.entrySet()) {
            double average = entry.getValue().stream()
                    .mapToDouble(Double::doubleValue)
                    .average()
                    .orElse(0.0);
            semesterAverages.put(entry.getKey(), average);
        }

        return semesterAverages;
    }

    /**
     * 更新预警级别（选择更高的级别）
     */
    private String updateWarningLevel(String currentLevel, String newLevel) {
        int currentPriority = getWarningPriority(currentLevel);
        int newPriority = getWarningPriority(newLevel);
        return newPriority > currentPriority ? newLevel : currentLevel;
    }

    /**
     * 获取预警级别优先级
     */
    private int getWarningPriority(String level) {
        switch (level.toLowerCase()) {
            case "high":
                return 3;
            case "medium":
                return 2;
            case "low":
                return 1;
            default:
                return 0;
        }
    }
}
