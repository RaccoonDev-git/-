package com.example.studentanalysissystem.mapper;

import com.example.studentanalysissystem.dto.response.ComprehensiveGradeResponse;
import com.example.studentanalysissystem.model.ComprehensiveGrade;
import com.example.studentanalysissystem.model.CourseWeightConfig;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Map;

/**
 * 综合成绩Mapper
 */
@Component
public class ComprehensiveGradeMapper {

    public ComprehensiveGradeResponse toResponse(ComprehensiveGrade grade,
            CourseWeightConfig weightConfig,
            Map<String, BigDecimal> regularScoreDetails) {
        if (grade == null) {
            return null;
        }

        ComprehensiveGradeResponse.WeightConfigInfo weightConfigInfo = null;
        if (weightConfig != null) {
            weightConfigInfo = ComprehensiveGradeResponse.WeightConfigInfo.builder()
                    .regularWeight(weightConfig.getRegularWeight())
                    .finalWeight(weightConfig.getFinalWeight())
                    .makeupWeight(weightConfig.getMakeupWeight())
                    .build();
        }

        return ComprehensiveGradeResponse.builder()
                .id(grade.getId())
                .studentId(grade.getStudent().getId())
                .studentName(grade.getStudent().getName())
                .studentNumber(grade.getStudent().getStudentNumber())
                .studentClass(grade.getStudent().getClassName())
                .courseId(grade.getCourse().getId())
                .courseCode(grade.getCourse().getCode())
                .courseName(grade.getCourse().getName())
                .regularScore(grade.getRegularScore())
                .regularScoreDetails(regularScoreDetails)
                .finalScore(grade.getFinalScore())
                .makeupScore(grade.getMakeupScore())
                .comprehensiveScore(grade.getComprehensiveScore())
                .finalGrade(grade.getFinalGrade())
                .gradeLevel(grade.getGradeLevel())
                .isPassed(grade.getIsPassed())
                .hasMakeup(grade.getHasMakeup())
                .weightConfig(weightConfigInfo)
                .semester(grade.getSemester())
                .academicYear(grade.getAcademicYear())
                .remarks(grade.getRemarks())
                .createdAt(grade.getCreatedAt())
                .updatedAt(grade.getUpdatedAt())
                .build();
    }
}
