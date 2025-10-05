package com.example.studentanalysissystem.service.impl;

import com.example.studentanalysissystem.dto.request.CreateStudentRequest;
import com.example.studentanalysissystem.dto.response.StudentResponse;
import com.example.studentanalysissystem.exception.DuplicateResourceException;
import com.example.studentanalysissystem.exception.ResourceNotFoundException;
import com.example.studentanalysissystem.mapper.StudentMapper;
import com.example.studentanalysissystem.model.Student;
import com.example.studentanalysissystem.model.User;
import com.example.studentanalysissystem.repository.StudentRepository;
import com.example.studentanalysissystem.repository.UserRepository;
import com.example.studentanalysissystem.service.StudentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 学生服务实现类
 */
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class StudentServiceImpl implements StudentService {

    private final StudentRepository studentRepository;
    private final UserRepository userRepository;
    private final StudentMapper studentMapper;

    @Override
    @Transactional
    public StudentResponse createStudent(CreateStudentRequest request) {
        // 检查用户是否存在
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", request.getUserId()));

        // 检查学号是否已存在
        if (studentRepository.existsByStudentNumber(request.getStudentNumber())) {
            throw new DuplicateResourceException("Student", "studentNumber", request.getStudentNumber());
        }

        // 创建学生实体
        Student student = Student.builder()
                .user(user)
                .studentNumber(request.getStudentNumber())
                .name(request.getName())
                .className(request.getClassName())
                .gradeLevel(request.getGradeLevel())
                .major(request.getMajor())
                .remarks(request.getRemarks())
                .build();

        Student savedStudent = studentRepository.save(student);
        return studentMapper.toResponse(savedStudent);
    }

    @Override
    public StudentResponse getStudentById(Long id) {
        Student student = studentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Student", "id", id));
        return studentMapper.toResponse(student);
    }

    @Override
    public StudentResponse getStudentByStudentNumber(String studentNumber) {
        Student student = studentRepository.findByStudentNumber(studentNumber)
                .orElseThrow(() -> new ResourceNotFoundException("Student", "studentNumber", studentNumber));
        return studentMapper.toResponse(student);
    }

    @Override
    public StudentResponse getStudentByUserId(Long userId) {
        Student student = studentRepository.findByUserId(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Student", "userId", userId));
        return studentMapper.toResponse(student);
    }

    @Override
    public List<StudentResponse> getAllStudents() {
        List<Student> students = studentRepository.findAll();
        return studentMapper.toResponseList(students);
    }

    @Override
    public List<StudentResponse> getStudentsByClassName(String className) {
        List<Student> students = studentRepository.findByClassName(className);
        return studentMapper.toResponseList(students);
    }

    @Override
    public List<StudentResponse> getStudentsByGradeLevel(Integer gradeLevel) {
        List<Student> students = studentRepository.findByGradeLevel(gradeLevel);
        return studentMapper.toResponseList(students);
    }

    @Override
    public List<StudentResponse> getStudentsByMajor(String major) {
        List<Student> students = studentRepository.findByMajor(major);
        return studentMapper.toResponseList(students);
    }

    @Override
    @Transactional
    public StudentResponse updateStudent(Long id,
            com.example.studentanalysissystem.dto.request.UpdateStudentRequest request) {
        Student student = studentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Student", "id", id));

        // 更新学生信息(只更新非空字段)
        if (request.getClassName() != null) {
            student.setClassName(request.getClassName());
        }
        if (request.getGradeLevel() != null) {
            student.setGradeLevel(request.getGradeLevel());
        }
        if (request.getMajor() != null) {
            student.setMajor(request.getMajor());
        }

        Student updatedStudent = studentRepository.save(student);
        return studentMapper.toResponse(updatedStudent);
    }

    @Override
    @Transactional
    public void deleteStudent(Long id) {
        Student student = studentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Student", "id", id));
        studentRepository.delete(student);
    }

    @Override
    public List<StudentResponse> searchStudents(String keyword) {
        List<Student> students = studentRepository.searchByKeyword(keyword);
        return studentMapper.toResponseList(students);
    }
}
