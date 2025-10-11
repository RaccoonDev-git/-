package com.example.studentanalysissystem.service;

import com.example.studentanalysissystem.dto.request.CalculateComprehensiveGradeRequest;
import com.example.studentanalysissystem.exception.ResourceNotFoundException;
import com.example.studentanalysissystem.model.*;
import com.example.studentanalysissystem.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * 综合成绩导入服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class ComprehensiveGradeImportService {

    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;
    private final ComprehensiveGradeService comprehensiveGradeService;
    private final CourseWeightConfigRepository courseWeightConfigRepository;

    /**
     * 导入综合成绩数据
     */
    @Transactional
    public ImportResult importComprehensiveGrades(MultipartFile file) {
        ImportResult result = new ImportResult();

        try {
            List<String[]> rows = parseCsvFile(file);
            if (rows.isEmpty()) {
                result.addError("文件为空或格式错误");
                return result;
            }

            // 验证表头
            String[] headers = rows.get(0);
            if (!validateHeaders(headers)) {
                result.addError("文件格式不正确，请使用提供的模板");
                return result;
            }

            // 处理数据行
            for (int i = 1; i < rows.size(); i++) {
                try {
                    processGradeRow(rows.get(i), headers, result, i + 1);
                } catch (Exception e) {
                    result.addError("第" + (i + 1) + "行处理失败: " + e.getMessage());
                }
            }

            log.info("综合成绩导入完成，成功: {}, 失败: {}", result.getSuccessCount(), result.getErrorCount());

        } catch (Exception e) {
            log.error("导入综合成绩失败", e);
            result.addError("导入失败: " + e.getMessage());
        }

        return result;
    }

    /**
     * 解析CSV文件
     */
    private List<String[]> parseCsvFile(MultipartFile file) throws Exception {
        List<String[]> rows = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] row = parseCsvLine(line);
                rows.add(row);
            }
        }

        return rows;
    }

    /**
     * 解析CSV行
     */
    private String[] parseCsvLine(String line) {
        List<String> fields = new ArrayList<>();
        boolean inQuotes = false;
        StringBuilder field = new StringBuilder();

        for (char c : line.toCharArray()) {
            if (c == '"') {
                inQuotes = !inQuotes;
            } else if (c == ',' && !inQuotes) {
                fields.add(field.toString().trim());
                field = new StringBuilder();
            } else {
                field.append(c);
            }
        }
        fields.add(field.toString().trim());

        return fields.toArray(new String[0]);
    }

    /**
     * 验证表头
     */
    private boolean validateHeaders(String[] headers) {
        String[] expectedHeaders = {
                "姓名", "学号", "年级", "班级", "专业", "课程名称", "学期", "学年",
                "签到成绩", "平时作业成绩", "实验成绩", "随堂测试成绩", "期末考试成绩", "补考成绩", "备注"
        };

        if (headers.length != expectedHeaders.length) {
            return false;
        }

        for (int i = 0; i < expectedHeaders.length; i++) {
            if (!expectedHeaders[i].equals(headers[i])) {
                return false;
            }
        }

        return true;
    }

    /**
     * 处理成绩行数据
     */
    private void processGradeRow(String[] row, String[] headers, ImportResult result, int rowNumber) {
        try {
            // 解析基础信息
            String studentNumber = row[1];
            String courseName = row[5];
            String semester = row[6];
            String academicYear = row[7];

            // 查找学生
            Student student = studentRepository.findByStudentNumber(studentNumber)
                    .orElseThrow(() -> new ResourceNotFoundException("Student", "studentNumber", studentNumber));

            // 查找课程
            Course course = courseRepository.findByName(courseName)
                    .orElseThrow(() -> new ResourceNotFoundException("Course", "name", courseName));

            // 解析成绩数据
            Map<String, BigDecimal> regularScores = new HashMap<>();
            regularScores.put("ATTENDANCE", parseScore(row[8])); // 签到成绩
            regularScores.put("HOMEWORK", parseScore(row[9])); // 平时作业成绩
            regularScores.put("LAB", parseScore(row[10])); // 实验成绩
            regularScores.put("QUIZ", parseScore(row[11])); // 随堂测试成绩

            BigDecimal finalScore = parseScore(row[12]); // 期末考试成绩
            BigDecimal makeupScore = parseScore(row[13]); // 补考成绩
            String remarks = row[14]; // 备注

            // 构建请求对象
            CalculateComprehensiveGradeRequest request = CalculateComprehensiveGradeRequest.builder()
                    .studentId(student.getId())
                    .courseId(course.getId())
                    .regularScores(regularScores)
                    .finalScore(finalScore)
                    .makeupScore(makeupScore)
                    .semester(semester)
                    .academicYear(academicYear)
                    .remarks(remarks)
                    .build();

            // 计算综合成绩
            comprehensiveGradeService.calculateComprehensiveGrade(request);
            result.incrementSuccess();

        } catch (Exception e) {
            result.addError("第" + rowNumber + "行: " + e.getMessage());
        }
    }

    /**
     * 解析成绩分数
     */
    private BigDecimal parseScore(String scoreStr) {
        if (scoreStr == null || scoreStr.trim().isEmpty()) {
            return null;
        }

        try {
            return new BigDecimal(scoreStr.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /**
     * 导入结果类
     */
    public static class ImportResult {
        private int successCount = 0;
        private List<String> errors = new ArrayList<>();

        public void incrementSuccess() {
            successCount++;
        }

        public void addError(String error) {
            errors.add(error);
        }

        public int getSuccessCount() {
            return successCount;
        }

        public int getErrorCount() {
            return errors.size();
        }

        public List<String> getErrors() {
            return errors;
        }

        public boolean hasErrors() {
            return !errors.isEmpty();
        }
    }
}
