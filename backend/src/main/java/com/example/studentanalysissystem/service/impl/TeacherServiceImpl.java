package com.example.studentanalysissystem.service.impl;

import com.example.studentanalysissystem.dto.request.CreateTeacherRequest;
import com.example.studentanalysissystem.dto.request.UpdateTeacherRequest;
import com.example.studentanalysissystem.dto.response.CourseResponse;
import com.example.studentanalysissystem.dto.response.TeacherResponse;
import com.example.studentanalysissystem.exception.DuplicateResourceException;
import com.example.studentanalysissystem.exception.ResourceNotFoundException;
import com.example.studentanalysissystem.mapper.TeacherMapper;
import com.example.studentanalysissystem.model.Teacher;
import com.example.studentanalysissystem.model.User;
import com.example.studentanalysissystem.repository.TeacherRepository;
import com.example.studentanalysissystem.repository.UserRepository;
import com.example.studentanalysissystem.service.CourseService;
import com.example.studentanalysissystem.service.StudentService;
import com.example.studentanalysissystem.service.TeacherService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.stream.Collectors;

/**
 * 教师服务实现类
 */
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TeacherServiceImpl implements TeacherService {

    private final TeacherRepository teacherRepository;
    private final UserRepository userRepository;
    private final TeacherMapper teacherMapper;
    private final CourseService courseService;
    private final StudentService studentService;

    @Override
    @Transactional
    public TeacherResponse createTeacher(CreateTeacherRequest request) {
        // 检查用户是否存在
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", request.getUserId()));

        // 检查工号是否已存在
        if (teacherRepository.existsByEmployeeNumber(request.getEmployeeNumber())) {
            throw new DuplicateResourceException("Teacher", "employeeNumber", request.getEmployeeNumber());
        }

        // 创建教师实体
        Teacher teacher = Teacher.builder()
                .user(user)
                .employeeNumber(request.getEmployeeNumber())
                .name(request.getName())
                .department(request.getDepartment())
                .title(request.getTitle())
                .remarks(request.getRemarks())
                .build();

        Teacher savedTeacher = teacherRepository.save(teacher);
        return teacherMapper.toResponse(savedTeacher);
    }

    @Override
    public TeacherResponse getTeacherById(Long id) {
        Teacher teacher = teacherRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Teacher", "id", id));
        return teacherMapper.toResponse(teacher);
    }

    @Override
    public TeacherResponse getTeacherByEmployeeNumber(String employeeNumber) {
        Teacher teacher = teacherRepository.findByEmployeeNumber(employeeNumber)
                .orElseThrow(() -> new ResourceNotFoundException("Teacher", "employeeNumber", employeeNumber));
        return teacherMapper.toResponse(teacher);
    }

    @Override
    public TeacherResponse getTeacherByUserId(Long userId) {
        Teacher teacher = teacherRepository.findByUserId(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Teacher", "userId", userId));
        return teacherMapper.toResponse(teacher);
    }

    @Override
    public List<TeacherResponse> getAllTeachers() {
        List<Teacher> teachers = teacherRepository.findAll();
        return teacherMapper.toResponseList(teachers);
    }

    @Override
    public List<TeacherResponse> getTeachersByDepartment(String department) {
        List<Teacher> teachers = teacherRepository.findByDepartment(department);
        return teacherMapper.toResponseList(teachers);
    }

    @Override
    public List<TeacherResponse> getTeachersByTitle(String title) {
        List<Teacher> teachers = teacherRepository.findByTitle(title);
        return teacherMapper.toResponseList(teachers);
    }

    @Override
    @Transactional
    public TeacherResponse updateTeacher(Long id, UpdateTeacherRequest request) {
        Teacher teacher = teacherRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Teacher", "id", id));

        // 更新教师信息
        if (request.getDepartment() != null) {
            teacher.setDepartment(request.getDepartment());
        }
        if (request.getTitle() != null) {
            teacher.setTitle(request.getTitle());
        }

        Teacher updatedTeacher = teacherRepository.save(teacher);
        return teacherMapper.toResponse(updatedTeacher);
    }

    @Override
    @Transactional
    public void deleteTeacher(Long id) {
        Teacher teacher = teacherRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Teacher", "id", id));
        teacherRepository.delete(teacher);
    }

    @Override
    public List<TeacherResponse> searchTeachers(String keyword) {
        List<Teacher> teachers = teacherRepository.searchByKeyword(keyword);
        return teacherMapper.toResponseList(teachers);
    }

    @Override
    public List<String> getTeacherClasses(Long teacherId) {
        // 获取教师的所有课程
        List<CourseResponse> teacherCourses = courseService.getCoursesByTeacherId(teacherId);
        
        // 获取这些课程对应的班级
        List<String> classes = teacherCourses.stream()
                .flatMap(course -> {
                    // 通过课程获取有学生选修的班级
                    try {
                        return studentService.getClassesByCourseId(course.getId()).stream();
                    } catch (Exception e) {
                        // 如果获取失败，返回空流
                        return java.util.stream.Stream.empty();
                    }
                })
                .distinct()
                .collect(Collectors.toList());
        
        return classes;
    }

    @Override
    public List<CourseResponse> getTeacherCourses(Long teacherId) {
        return courseService.getCoursesByTeacherId(teacherId);
    }

    @Override
    public List<CourseResponse> getTeacherCoursesInClass(Long teacherId, String className) {
        // 获取教师的所有课程
        List<CourseResponse> teacherCourses = courseService.getCoursesByTeacherId(teacherId);
        
        // 过滤出在该班级有学生的课程
        return teacherCourses.stream()
                .filter(course -> {
                    try {
                        List<String> courseClasses = studentService.getClassesByCourseId(course.getId());
                        return courseClasses.contains(className);
                    } catch (Exception e) {
                        return false;
                    }
                })
                .collect(Collectors.toList());
    }

    @Override
    public Map<String, Object> getTeacherAnalysisData(Long teacherId) {
        Map<String, Object> analysisData = new HashMap<>();
        
        // 获取教师所教的班级
        List<String> teacherClasses = getTeacherClasses(teacherId);
        
        // 获取教师的所有课程
        List<CourseResponse> teacherCourses = getTeacherCourses(teacherId);
        
        // 构建分析数据结构
        Map<String, Object> classData = new HashMap<>();
        
        for (String className : teacherClasses) {
            // 获取该班级的课程
            List<CourseResponse> classCourses = getTeacherCoursesInClass(teacherId, className);
            
            // 构建课程数据
            Map<String, Object> courseData = new HashMap<>();
            for (CourseResponse course : classCourses) {
                // 获取该课程在该班级的学生成绩数据
                List<Map<String, Object>> studentScores = studentService.getStudentScoresByCourseAndClass(course.getId(), className);
                courseData.put(course.getName(), studentScores);
            }
            
            classData.put(className, courseData);
        }
        
        analysisData.put("classes", teacherClasses);
        analysisData.put("courses", teacherCourses.stream().map(CourseResponse::getName).collect(Collectors.toList()));
        analysisData.put("analysisData", classData);
        
        return analysisData;
    }

    @Override
    public List<com.example.studentanalysissystem.dto.response.StudentResponse> getTeacherStudents(Long teacherId) {
        // 获取教师所教的班级
        List<String> teacherClasses = getTeacherClasses(teacherId);
        
        // 获取这些班级的所有学生
        List<com.example.studentanalysissystem.dto.response.StudentResponse> allStudents = new ArrayList<>();
        
        for (String className : teacherClasses) {
            List<com.example.studentanalysissystem.dto.response.StudentResponse> classStudents = 
                studentService.getStudentsByClassName(className);
            allStudents.addAll(classStudents);
        }
        
        return allStudents;
    }
}