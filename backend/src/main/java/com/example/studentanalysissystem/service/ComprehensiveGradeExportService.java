package com.example.studentanalysissystem.service;

import com.example.studentanalysissystem.dto.response.ComprehensiveGradeResponse;
import com.example.studentanalysissystem.model.ComprehensiveGrade;
import com.example.studentanalysissystem.repository.ComprehensiveGradeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * 综合成绩导出服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ComprehensiveGradeExportService {

    private final ComprehensiveGradeRepository comprehensiveGradeRepository;

    /**
     * 导出课程综合成绩
     */
    public byte[] exportCourseGrades(Long courseId) throws IOException {
        List<ComprehensiveGrade> grades = comprehensiveGradeRepository.findByCourseId(courseId);
        return generateCsv(grades);
    }

    /**
     * 导出学生综合成绩
     */
    public byte[] exportStudentGrades(Long studentId) throws IOException {
        List<ComprehensiveGrade> grades = comprehensiveGradeRepository.findByStudentId(studentId);
        return generateCsv(grades);
    }

    /**
     * 导出所有综合成绩
     */
    public byte[] exportAllGrades() throws IOException {
        List<ComprehensiveGrade> grades = comprehensiveGradeRepository.findAll();
        return generateCsv(grades);
    }

    /**
     * 生成CSV文件
     */
    private byte[] generateCsv(List<ComprehensiveGrade> grades) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        OutputStreamWriter writer = new OutputStreamWriter(outputStream, StandardCharsets.UTF_8);

        try {
            // 写入BOM，确保Excel正确识别UTF-8编码
            outputStream.write(0xEF);
            outputStream.write(0xBB);
            outputStream.write(0xBF);

            // 写入表头
            writer.write("姓名,学号,年级,班级,专业,课程名称,课程代码,学期,学年,");
            writer.write("签到成绩,平时作业成绩,实验成绩,随堂测试成绩,平时分总分,");
            writer.write("期末考试成绩,补考成绩,综合成绩,最终成绩,成绩等级,是否通过,备注,创建时间\n");

            // 写入数据
            for (ComprehensiveGrade grade : grades) {
                writer.write(formatGradeRow(grade));
            }

            writer.flush();
            return outputStream.toByteArray();

        } finally {
            writer.close();
            outputStream.close();
        }
    }

    /**
     * 格式化成绩行数据
     */
    private String formatGradeRow(ComprehensiveGrade grade) {
        StringBuilder row = new StringBuilder();

        // 学生信息
        row.append(escapeCsvField(grade.getStudent().getName())).append(",");
        row.append(escapeCsvField(grade.getStudent().getStudentNumber())).append(",");
        row.append(escapeCsvField(grade.getStudent().getGradeLevel().toString())).append(",");
        row.append(escapeCsvField(grade.getStudent().getClassName())).append(",");
        row.append(escapeCsvField(grade.getStudent().getMajor())).append(",");

        // 课程信息
        row.append(escapeCsvField(grade.getCourse().getName())).append(",");
        row.append(escapeCsvField(grade.getCourse().getCode())).append(",");
        row.append(escapeCsvField(grade.getSemester())).append(",");
        row.append(escapeCsvField(grade.getAcademicYear())).append(",");

        // 成绩信息（这里需要根据实际的平时分类型来调整）
        // 暂时使用占位符，实际实现时需要从相关的成绩表中获取详细数据
        row.append(grade.getRegularScore() != null ? grade.getRegularScore().toString() : "").append(",");
        row.append(grade.getRegularScore() != null ? grade.getRegularScore().toString() : "").append(",");
        row.append(grade.getRegularScore() != null ? grade.getRegularScore().toString() : "").append(",");
        row.append(grade.getRegularScore() != null ? grade.getRegularScore().toString() : "").append(",");
        row.append(grade.getRegularScore() != null ? grade.getRegularScore().toString() : "").append(",");

        row.append(grade.getFinalScore() != null ? grade.getFinalScore().toString() : "").append(",");
        row.append(grade.getMakeupScore() != null ? grade.getMakeupScore().toString() : "").append(",");
        row.append(grade.getComprehensiveScore() != null ? grade.getComprehensiveScore().toString() : "").append(",");
        row.append(grade.getFinalGrade() != null ? grade.getFinalGrade().toString() : "").append(",");
        row.append(escapeCsvField(grade.getGradeLevel())).append(",");
        row.append(grade.getIsPassed() ? "是" : "否").append(",");
        row.append(escapeCsvField(grade.getRemarks())).append(",");
        row.append(grade.getCreatedAt() != null ? grade.getCreatedAt().toString() : "");
        row.append("\n");

        return row.toString();
    }

    /**
     * 转义CSV字段
     */
    private String escapeCsvField(String field) {
        if (field == null) {
            return "";
        }

        // 如果包含逗号、引号或换行符，需要用引号包围并转义引号
        if (field.contains(",") || field.contains("\"") || field.contains("\n")) {
            return "\"" + field.replace("\"", "\"\"") + "\"";
        }

        return field;
    }

    /**
     * 生成导入模板
     */
    public byte[] generateImportTemplate() throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        OutputStreamWriter writer = new OutputStreamWriter(outputStream, StandardCharsets.UTF_8);

        try {
            // 写入BOM
            outputStream.write(0xEF);
            outputStream.write(0xBB);
            outputStream.write(0xBF);

            // 写入表头
            writer.write("姓名,学号,年级,班级,专业,课程名称,学期,学年,");
            writer.write("签到成绩,平时作业成绩,实验成绩,随堂测试成绩,期末考试成绩,补考成绩,备注\n");

            // 写入示例数据
            writer.write("张三,20191001,2019,19软工A1,软件工程,数据结构,2024春季,2023-2024,95,88,92,85,78,,\n");
            writer.write("李四,20191002,2019,19软工A1,软件工程,数据结构,2024春季,2023-2024,85,82,78,80,65,75,已补考\n");

            writer.flush();
            return outputStream.toByteArray();

        } finally {
            writer.close();
            outputStream.close();
        }
    }
}
