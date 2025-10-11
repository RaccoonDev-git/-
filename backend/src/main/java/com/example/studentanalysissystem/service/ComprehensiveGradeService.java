package com.example.studentanalysissystem.service;

import com.example.studentanalysissystem.dto.request.CalculateComprehensiveGradeRequest;
import com.example.studentanalysissystem.dto.response.ComprehensiveGradeResponse;

import java.util.List;

/**
 * 综合成绩服务接口
 */
public interface ComprehensiveGradeService {

    /**
     * 计算综合成绩
     */
    ComprehensiveGradeResponse calculateComprehensiveGrade(CalculateComprehensiveGradeRequest request);

    /**
     * 根据学生ID获取综合成绩
     */
    List<ComprehensiveGradeResponse> getComprehensiveGradesByStudentId(Long studentId);

    /**
     * 根据课程ID获取综合成绩
     */
    List<ComprehensiveGradeResponse> getComprehensiveGradesByCourseId(Long courseId);

    /**
     * 根据学生ID和课程ID获取综合成绩
     */
    ComprehensiveGradeResponse getComprehensiveGradeByStudentAndCourse(Long studentId, Long courseId);

    /**
     * 批量计算课程的综合成绩
     */
    List<ComprehensiveGradeResponse> batchCalculateComprehensiveGrades(Long courseId);

    /**
     * 重新计算所有综合成绩
     */
    void recalculateAllComprehensiveGrades();

    /**
     * 更新补考成绩
     */
    ComprehensiveGradeResponse updateMakeupScore(Long studentId, Long courseId, Double makeupScore);

    /**
     * 获取学生成绩统计
     */
    Object getStudentGradeStatistics(Long studentId);

    /**
     * 获取课程成绩统计
     */
    Object getCourseGradeStatistics(Long courseId);
}
