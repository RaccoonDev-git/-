package com.example.studentanalysissystem.dto.request;

import lombok.Data;

/**
 * 更新学生请求DTO
 */
@Data
public class UpdateStudentRequest {

    private String className;

    private Integer gradeLevel;

    private String major;

    private String gender;

    private String contactPhone;

    private String address;
}
