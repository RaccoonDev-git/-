package com.example.studentanalysissystem.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * 学生预警响应DTO
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StudentWarningResponse {

    // 学生基本信息
    private Long studentId;
    private String studentName;
    private String studentNumber;
    private String className;
    private String major;

    // 预警级别: high(高危), medium(中等), low(低危), none(无)
    private String warningLevel;

    // 预警问题列表
    private List<String> warningMessages;

    // 建议列表
    private List<String> suggestions;

    // 学业统计
    private Integer failedCourseCount; // 不及格课程数
    private Integer totalCourseCount; // 总课程数
    private Double averageScore; // 平均成绩
    private Double scoreChange; // 成绩变化趋势

    // 学习活动统计
    private Date lastLoginDate; // 最后登录时间
    private Long daysSinceLastLogin; // 距上次登录天数
    private Integer recentActivityCount; // 最近30天活动次数

    // 优先级（用于排序）
    private Integer priority; // 优先级: 1(最高), 2(中等), 3(较低)
}