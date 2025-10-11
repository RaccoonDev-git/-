package com.example.studentanalysissystem.service;

/**
 * 成绩重新计算服务接口
 * 当权重配置或成绩类型发生变化时，自动重新计算相关成绩
 */
public interface GradeRecalculationService {

    /**
     * 当课程权重配置发生变化时，重新计算该课程的所有综合成绩
     * 
     * @param courseId 课程ID
     */
    void recalculateCourseGrades(Long courseId);

    /**
     * 当平时分类型权重发生变化时，重新计算所有相关课程的综合成绩
     * 
     * @param gradeTypeId 成绩类型ID
     */
    void recalculateGradesByGradeType(Long gradeTypeId);

    /**
     * 当平时分类型被删除时，重新计算所有相关课程的综合成绩
     * 
     * @param gradeTypeId 成绩类型ID
     */
    void recalculateGradesAfterGradeTypeDeletion(Long gradeTypeId);

    /**
     * 当平时分类型被添加时，重新计算所有相关课程的综合成绩
     * 
     * @param gradeTypeId 成绩类型ID
     */
    void recalculateGradesAfterGradeTypeAddition(Long gradeTypeId);

    /**
     * 重新计算所有综合成绩（用于系统维护）
     */
    void recalculateAllGrades();

    /**
     * 检查并修复数据一致性
     * 
     * @param courseId 课程ID，null表示检查所有课程
     */
    void checkAndFixDataConsistency(Long courseId);
}
