package com.example.studentanalysissystem.service;

import com.example.studentanalysissystem.dto.response.StudentProfileResponse;
import com.example.studentanalysissystem.model.*;
import com.example.studentanalysissystem.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 学生分析服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class StudentAnalysisService {

    private final StudentRepository studentRepository;
    private final GradeRepository gradeRepository;
    private final CourseRepository courseRepository;
    private final LearningActivityRepository activityRepository;

    /**
     * 获取学生个人学习档案
     */
    public StudentProfileResponse getStudentProfile(Long studentId) {
        log.info("获取学生学习档案: studentId={}", studentId);

        // 获取学生信息
        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException("学生不存在: " + studentId));

        // 获取学生所有成绩
        List<Grade> grades = gradeRepository.findByStudentId(studentId);

        if (grades.isEmpty()) {
            log.warn("学生{}没有成绩记录", studentId);
            return createEmptyProfile(student);
        }

        // 构建学习档案
        return StudentProfileResponse.builder()
                .studentId(student.getId())
                .studentName(student.getName())
                .studentNumber(student.getStudentNumber())
                .className(student.getClassName())
                .gradeLevel(student.getGradeLevel())
                .major(student.getMajor())
                .summary(calculateSummary(student, grades))
                .scoreTrend(calculateScoreTrend(grades))
                .subjectAnalysis(analyzeSubjects(student, grades))
                .learningActivity(analyzeLearningActivity(studentId))
                .suggestions(generateSuggestions(student, grades))
                .build();
    }

    /**
     * 计算总体概览
     */
    private StudentProfileResponse.Summary calculateSummary(Student student, List<Grade> grades) {
        // 计算总平均分
        double overallAverage = grades.stream()
                .mapToDouble(g -> g.getScore().doubleValue())
                .average()
                .orElse(0.0);

        // 获取课程统计
        int totalCourses = (int) grades.stream()
                .map(g -> g.getCourse().getId())
                .distinct()
                .count();

        int passedCourses = (int) grades.stream()
                .filter(g -> g.getScore().doubleValue() >= 60)
                .map(g -> g.getCourse().getId())
                .distinct()
                .count();

        int failedCourses = totalCourses - passedCourses;

        // 计算班级排名
        Integer classRank = calculateClassRank(student, overallAverage);
        Integer classSize = getClassSize(student.getClassName());

        // 计算GPA(简化版: 90-100=4.0, 80-89=3.0, 70-79=2.0, 60-69=1.0, <60=0)
        double gpa = grades.stream()
                .mapToDouble(g -> {
                    double score = g.getScore().doubleValue();
                    if (score >= 90)
                        return 4.0;
                    else if (score >= 80)
                        return 3.0;
                    else if (score >= 70)
                        return 2.0;
                    else if (score >= 60)
                        return 1.0;
                    else
                        return 0.0;
                })
                .average()
                .orElse(0.0);

        return StudentProfileResponse.Summary.builder()
                .overallAverage(Math.round(overallAverage * 100.0) / 100.0)
                .classRank(classRank)
                .classSize(classSize)
                .totalCourses(totalCourses)
                .passedCourses(passedCourses)
                .failedCourses(failedCourses)
                .gpa(Math.round(gpa * 100.0) / 100.0)
                .build();
    }

    /**
     * 计算成绩趋势
     */
    private List<StudentProfileResponse.SemesterScore> calculateScoreTrend(List<Grade> grades) {
        // 按学期分组
        Map<String, List<Grade>> semesterGrades = grades.stream()
                .filter(g -> g.getCourse().getSemester() != null)
                .collect(Collectors.groupingBy(g -> g.getCourse().getSemester()));

        return semesterGrades.entrySet().stream()
                .map(entry -> {
                    String semester = entry.getKey();
                    List<Grade> semGrades = entry.getValue();

                    double average = semGrades.stream()
                            .mapToDouble(g -> g.getScore().doubleValue())
                            .average()
                            .orElse(0.0);

                    int courseCount = (int) semGrades.stream()
                            .map(g -> g.getCourse().getId())
                            .distinct()
                            .count();

                    int passedCount = (int) semGrades.stream()
                            .filter(g -> g.getScore().doubleValue() >= 60)
                            .count();

                    return StudentProfileResponse.SemesterScore.builder()
                            .semester(semester)
                            .average(Math.round(average * 100.0) / 100.0)
                            .courseCount(courseCount)
                            .passedCount(passedCount)
                            .build();
                })
                .sorted(Comparator.comparing(StudentProfileResponse.SemesterScore::getSemester))
                .collect(Collectors.toList());
    }

    /**
     * 分析各科目表现
     */
    private List<StudentProfileResponse.SubjectAnalysis> analyzeSubjects(Student student, List<Grade> grades) {
        return grades.stream()
                .map(grade -> {
                    Course course = grade.getCourse();
                    double studentScore = grade.getScore().doubleValue();

                    // 计算班级平均分
                    double classAverage = calculateCourseClassAverage(course.getId(), student.getClassName());

                    // 计算班级排名
                    int rank = calculateCourseRank(course.getId(), student.getId(), student.getClassName());

                    // 判断趋势(简化版,这里假设只有一次成绩,实际应该对比历史)
                    String trend = determineTrend(studentScore, classAverage);

                    // 分类科目
                    String category = categorizeSubject(studentScore, classAverage);

                    // 计算与班级平均分的差值
                    double difference = Math.round((studentScore - classAverage) * 100.0) / 100.0;

                    return StudentProfileResponse.SubjectAnalysis.builder()
                            .courseId(course.getId())
                            .courseName(course.getName())
                            .score(studentScore)
                            .classAverage(Math.round(classAverage * 100.0) / 100.0)
                            .rank(rank)
                            .trend(trend)
                            .category(category)
                            .difference(difference)
                            .semester(course.getSemester())
                            .build();
                })
                .sorted(Comparator.comparing(StudentProfileResponse.SubjectAnalysis::getScore).reversed())
                .collect(Collectors.toList());
    }

    /**
     * 分析学习活动
     */
    private StudentProfileResponse.LearningActivity analyzeLearningActivity(Long studentId) {
        // 统计总学习时长
        Integer totalStudyTime = activityRepository.sumDurationByStudentId(studentId);
        if (totalStudyTime == null)
            totalStudyTime = 0;

        // 统计登录次数
        Long loginCount = activityRepository.countLoginsByStudentId(studentId);

        // 获取最后登录时间
        Optional<LearningActivity> lastActivity = activityRepository
                .findTop1ByStudentIdOrderByCreatedAtDesc(studentId);

        String lastLoginDate = lastActivity
                .map(a -> a.getCreatedAt().toLocalDate().toString())
                .orElse("从未登录");

        // 计算活跃度
        String activeLevel = determineActiveLevel(loginCount.intValue(), totalStudyTime);

        // 计算平均每天学习时长(假设统计30天内的)
        int avgStudyTimePerDay = totalStudyTime / 30;

        return StudentProfileResponse.LearningActivity.builder()
                .loginCount(loginCount.intValue())
                .totalStudyTime(totalStudyTime)
                .activeLevel(activeLevel)
                .avgStudyTimePerDay(avgStudyTimePerDay)
                .lastLoginDate(lastLoginDate)
                .build();
    }

    /**
     * 生成学习建议
     */
    private List<String> generateSuggestions(Student student, List<Grade> grades) {
        List<String> suggestions = new ArrayList<>();

        // 分析弱科
        List<Grade> weakSubjects = grades.stream()
                .filter(g -> g.getScore().doubleValue() < 70)
                .sorted(Comparator.comparing(g -> g.getScore().doubleValue()))
                .limit(3)
                .collect(Collectors.toList());

        if (!weakSubjects.isEmpty()) {
            for (Grade grade : weakSubjects) {
                suggestions.add(String.format("%s成绩为%.1f分,需要重点关注,建议增加学习时间和练习量",
                        grade.getCourse().getName(), grade.getScore().doubleValue()));
            }
        }

        // 分析挂科课程
        List<Grade> failedSubjects = grades.stream()
                .filter(g -> g.getScore().doubleValue() < 60)
                .collect(Collectors.toList());

        if (!failedSubjects.isEmpty()) {
            suggestions.add(String.format("有%d门课程不及格,建议尽快与任课教师沟通,制定补救计划",
                    failedSubjects.size()));
        }

        // 分析强科
        List<Grade> strongSubjects = grades.stream()
                .filter(g -> g.getScore().doubleValue() >= 90)
                .collect(Collectors.toList());

        if (!strongSubjects.isEmpty()) {
            Grade best = strongSubjects.get(0);
            suggestions.add(String.format("%s表现优秀(%.1f分),可以尝试更高难度的题目或参加相关竞赛",
                    best.getCourse().getName(), best.getScore().doubleValue()));
        }

        // 总体建议
        double overallAverage = grades.stream()
                .mapToDouble(g -> g.getScore().doubleValue())
                .average()
                .orElse(0.0);

        if (overallAverage >= 85) {
            suggestions.add("整体成绩优秀,建议保持当前学习状态,可以适当拓展知识深度");
        } else if (overallAverage >= 75) {
            suggestions.add("整体成绩良好,建议重点突破弱势科目,争取更均衡的发展");
        } else if (overallAverage >= 60) {
            suggestions.add("部分科目需要加强,建议合理分配学习时间,提高学习效率");
        } else {
            suggestions.add("学习状况需要紧急关注,建议及时寻求老师和同学的帮助");
        }

        return suggestions;
    }

    /**
     * 计算班级排名
     */
    private Integer calculateClassRank(Student student, double studentAverage) {
        if (student.getClassName() == null)
            return null;

        // 获取同班级所有学生
        List<Student> classmates = studentRepository.findByClassName(student.getClassName());

        // 计算每个学生的平均分并排序
        List<Map.Entry<Long, Double>> rankings = classmates.stream()
                .map(s -> {
                    List<Grade> grades = gradeRepository.findByStudentId(s.getId());
                    double avg = grades.stream()
                            .mapToDouble(g -> g.getScore().doubleValue())
                            .average()
                            .orElse(0.0);
                    return Map.entry(s.getId(), avg);
                })
                .sorted(Map.Entry.<Long, Double>comparingByValue().reversed())
                .collect(Collectors.toList());

        // 找到当前学生的排名
        for (int i = 0; i < rankings.size(); i++) {
            if (rankings.get(i).getKey().equals(student.getId())) {
                return i + 1;
            }
        }

        return null;
    }

    /**
     * 获取班级人数
     */
    private Integer getClassSize(String className) {
        if (className == null)
            return 0;
        return studentRepository.findByClassName(className).size();
    }

    /**
     * 计算某课程在班级的平均分
     */
    private double calculateCourseClassAverage(Long courseId, String className) {
        if (className == null)
            return 0.0;

        List<Student> classmates = studentRepository.findByClassName(className);
        List<Long> classmateIds = classmates.stream()
                .map(Student::getId)
                .collect(Collectors.toList());

        List<Grade> classGrades = gradeRepository.findByCourseIdAndStudentIdIn(courseId, classmateIds);

        return classGrades.stream()
                .mapToDouble(g -> g.getScore().doubleValue())
                .average()
                .orElse(0.0);
    }

    /**
     * 计算某课程的班级排名
     */
    private int calculateCourseRank(Long courseId, Long studentId, String className) {
        if (className == null)
            return 0;

        List<Student> classmates = studentRepository.findByClassName(className);
        List<Long> classmateIds = classmates.stream()
                .map(Student::getId)
                .collect(Collectors.toList());

        List<Grade> classGrades = gradeRepository.findByCourseIdAndStudentIdIn(courseId, classmateIds);

        // 按分数降序排序
        List<Long> rankedStudentIds = classGrades.stream()
                .sorted(Comparator.comparing((Grade g) -> g.getScore().doubleValue()).reversed())
                .map(g -> g.getStudent().getId())
                .collect(Collectors.toList());

        return rankedStudentIds.indexOf(studentId) + 1;
    }

    /**
     * 判断成绩趋势
     */
    private String determineTrend(double studentScore, double classAverage) {
        double diff = studentScore - classAverage;
        if (diff > 10)
            return "improving";
        if (diff < -10)
            return "declining";
        return "stable";
    }

    /**
     * 科目分类
     */
    private String categorizeSubject(double studentScore, double classAverage) {
        double diff = studentScore - classAverage;
        if (diff > 10)
            return "strong";
        if (diff < -10)
            return "weak";
        return "average";
    }

    /**
     * 判断活跃度
     */
    private String determineActiveLevel(int loginCount, int studyTime) {
        if (loginCount > 50 && studyTime > 1000)
            return "high";
        if (loginCount > 20 && studyTime > 500)
            return "medium";
        return "low";
    }

    /**
     * 创建空档案
     */
    private StudentProfileResponse createEmptyProfile(Student student) {
        return StudentProfileResponse.builder()
                .studentId(student.getId())
                .studentName(student.getName())
                .studentNumber(student.getStudentNumber())
                .className(student.getClassName())
                .gradeLevel(student.getGradeLevel())
                .major(student.getMajor())
                .summary(StudentProfileResponse.Summary.builder()
                        .overallAverage(0.0)
                        .classRank(0)
                        .classSize(0)
                        .totalCourses(0)
                        .passedCourses(0)
                        .failedCourses(0)
                        .gpa(0.0)
                        .build())
                .scoreTrend(new ArrayList<>())
                .subjectAnalysis(new ArrayList<>())
                .learningActivity(StudentProfileResponse.LearningActivity.builder()
                        .loginCount(0)
                        .totalStudyTime(0)
                        .activeLevel("low")
                        .avgStudyTimePerDay(0)
                        .lastLoginDate("从未登录")
                        .build())
                .suggestions(List.of("暂无成绩数据,无法生成学习建议"))
                .build();
    }
}