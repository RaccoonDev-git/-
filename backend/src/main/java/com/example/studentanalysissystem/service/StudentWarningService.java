package com.example.studentanalysissystem.service;

import com.example.studentanalysissystem.dto.response.StudentWarningResponse;

import java.util.List;

/**
 * 学生预警服务接口
 */
public interface StudentWarningService {

    /**
     * 检查并生成学生预警
     */
    void checkAndGenerateWarnings(Long courseId);

    /**
     * 检查并生成所有课程的预警
     */
    void checkAndGenerateAllWarnings();

    /**
     * 根据学生ID获取预警
     */
    List<StudentWarningResponse> getWarningsByStudentId(Long studentId);

    /**
     * 根据课程ID获取预警
     */
    List<StudentWarningResponse> getWarningsByCourseId(Long courseId);

    /**
     * 获取未处理的预警
     */
    List<StudentWarningResponse> getUnhandledWarnings();

    /**
     * 处理预警
     */
    void handleWarning(Long warningId, Long handledBy, String handleRemarks);

    /**
     * 批量处理预警
     */
    void batchHandleWarnings(List<Long> warningIds, Long handledBy, String handleRemarks);

    /**
     * 删除预警
     */
    void deleteWarning(Long warningId);

    /**
     * 获取预警统计
     */
    Object getWarningStatistics();
}