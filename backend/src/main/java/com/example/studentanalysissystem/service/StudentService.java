package com.example.studentanalysissystem.service;

import com.example.studentanalysissystem.dto.request.CreateStudentRequest;
import com.example.studentanalysissystem.dto.response.StudentResponse;

import java.util.List;

/**
 * 学生服务接口
 */
public interface StudentService {

    /**
     * 创建学生
     */
    StudentResponse createStudent(CreateStudentRequest request);

    /**
     * 根据ID查询学生
     */
    StudentResponse getStudentById(Long id);

    /**
     * 根据学号查询学生
     */
    StudentResponse getStudentByStudentNumber(String studentNumber);

    /**
     * 根据用户ID查询学生
     */
    StudentResponse getStudentByUserId(Long userId);

    /**
     * 查询所有学生
     */
    List<StudentResponse> getAllStudents();

    /**
     * 根据班级查询学生
     */
    List<StudentResponse> getStudentsByClassName(String className);

    /**
     * 根据年级查询学生
     */
    List<StudentResponse> getStudentsByGradeLevel(Integer gradeLevel);

    /**
     * 根据专业查询学生
     */
    List<StudentResponse> getStudentsByMajor(String major);

    /**
     * 更新学生信息
     */
    StudentResponse updateStudent(Long id, com.example.studentanalysissystem.dto.request.UpdateStudentRequest request);

    /**
     * 删除学生
     */
    void deleteStudent(Long id);

    /**
     * 搜索学生 (根据姓名或学号)
     */
    List<StudentResponse> searchStudents(String keyword);
}
