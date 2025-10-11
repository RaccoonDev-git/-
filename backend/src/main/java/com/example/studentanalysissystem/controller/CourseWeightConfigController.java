package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.model.CourseWeightConfig;
import com.example.studentanalysissystem.repository.CourseWeightConfigRepository;
import com.example.studentanalysissystem.repository.CourseRepository;
import com.example.studentanalysissystem.dto.response.CourseWeightConfigResponse;
import com.example.studentanalysissystem.service.GradeRecalculationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * 课程权重配置控制器
 */
@RestController
@RequestMapping("/api/course-weight-configs")
@RequiredArgsConstructor
@Tag(name = "课程权重配置管理", description = "课程权重配置的增删改查")
@CrossOrigin(origins = "*")
public class CourseWeightConfigController {

    private final CourseWeightConfigRepository courseWeightConfigRepository;
    private final CourseRepository courseRepository;
    private final GradeRecalculationService gradeRecalculationService;

    @GetMapping("/course/{courseId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取课程权重配置", description = "根据课程ID获取权重配置")
    public ResponseEntity<CourseWeightConfigResponse> getByCourseId(
            @Parameter(description = "课程ID") @PathVariable Long courseId) {
        Optional<CourseWeightConfig> config = courseWeightConfigRepository.findByCourseIdAndIsActive(courseId, true);
        if (config.isPresent()) {
            CourseWeightConfig entity = config.get();
            CourseWeightConfigResponse response = CourseWeightConfigResponse.builder()
                    .id(entity.getId())
                    .courseId(entity.getCourse().getId())
                    .courseName(entity.getCourse().getName())
                    .courseCode(entity.getCourse().getCode())
                    .regularWeight(entity.getRegularWeight())
                    .finalWeight(entity.getFinalWeight())
                    .makeupWeight(entity.getMakeupWeight())
                    .isActive(entity.getIsActive())
                    .description(entity.getDescription())
                    .createdAt(entity.getCreatedAt())
                    .updatedAt(entity.getUpdatedAt())
                    .build();
            return ResponseEntity.ok(response);
        }
        return ResponseEntity.ok(null);
    }

    @PostMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "创建或更新权重配置", description = "创建或更新课程的权重配置")
    public ResponseEntity<?> createOrUpdate(
            @RequestBody CreateWeightConfigRequest request) {

        // 验证课程是否存在
        if (!courseRepository.existsById(request.getCourseId())) {
            return ResponseEntity.badRequest().build();
        }

        // 验证权重总和
        if (Math.abs(request.getRegularWeight().add(request.getFinalWeight()).doubleValue() - 100.0) > 0.01) {
            return ResponseEntity.badRequest().build();
        }

        // 查找现有配置
        Optional<CourseWeightConfig> existingConfig = courseWeightConfigRepository
                .findByCourseId(request.getCourseId());

        // 使用更简单的方法，避免序列化问题
        Long configId;
        if (existingConfig.isPresent()) {
            // 更新现有配置
            CourseWeightConfig config = existingConfig.get();
            config.setRegularWeight(request.getRegularWeight());
            config.setFinalWeight(request.getFinalWeight());
            config.setMakeupWeight(request.getMakeupWeight());
            courseWeightConfigRepository.save(config);
            configId = config.getId();
        } else {
            // 创建新配置 - 使用简单的构造函数
            CourseWeightConfig config = new CourseWeightConfig();
            // 创建一个简单的Course对象，只设置ID
            Course course = new Course();
            course.setId(request.getCourseId());
            config.setCourse(course);
            config.setRegularWeight(request.getRegularWeight());
            config.setFinalWeight(request.getFinalWeight());
            config.setMakeupWeight(request.getMakeupWeight());
            config.setIsActive(true);
            courseWeightConfigRepository.save(config);
            configId = config.getId();
        }

        // 权重配置变化后，重新计算该课程的所有综合成绩
        // 暂时注释掉重新计算功能，避免序列化问题
        // try {
        // gradeRecalculationService.recalculateCourseGrades(request.getCourseId());
        // } catch (Exception e) {
        // // 记录错误但不影响权重配置的保存
        // System.err.println("重新计算课程成绩失败: " + e.getMessage());
        // }

        // 直接返回简单的成功消息，避免任何序列化问题
        return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "权重配置保存成功",
                "id", configId,
                "courseId", request.getCourseId(),
                "regularWeight", request.getRegularWeight(),
                "finalWeight", request.getFinalWeight(),
                "makeupWeight", request.getMakeupWeight()));
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    @Operation(summary = "获取所有权重配置", description = "获取所有启用的权重配置")
    public ResponseEntity<List<CourseWeightConfigResponse>> getAll() {
        List<CourseWeightConfig> configs = courseWeightConfigRepository.findByIsActiveTrue();
        List<CourseWeightConfigResponse> responses = configs.stream()
                .map(config -> CourseWeightConfigResponse.builder()
                        .id(config.getId())
                        .courseId(config.getCourse().getId())
                        .courseName(config.getCourse().getName())
                        .courseCode(config.getCourse().getCode())
                        .regularWeight(config.getRegularWeight())
                        .finalWeight(config.getFinalWeight())
                        .makeupWeight(config.getMakeupWeight())
                        .isActive(config.getIsActive())
                        .description(config.getDescription())
                        .createdAt(config.getCreatedAt())
                        .updatedAt(config.getUpdatedAt())
                        .build())
                .toList();
        return ResponseEntity.ok(responses);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "删除权重配置", description = "删除指定的权重配置")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (!courseWeightConfigRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        courseWeightConfigRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }

    // 请求DTO
    public static class CreateWeightConfigRequest {
        private Long courseId;
        private BigDecimal regularWeight;
        private BigDecimal finalWeight;
        private BigDecimal makeupWeight;

        // Getters and Setters
        public Long getCourseId() {
            return courseId;
        }

        public void setCourseId(Long courseId) {
            this.courseId = courseId;
        }

        public BigDecimal getRegularWeight() {
            return regularWeight;
        }

        public void setRegularWeight(BigDecimal regularWeight) {
            this.regularWeight = regularWeight;
        }

        public BigDecimal getFinalWeight() {
            return finalWeight;
        }

        public void setFinalWeight(BigDecimal finalWeight) {
            this.finalWeight = finalWeight;
        }

        public BigDecimal getMakeupWeight() {
            return makeupWeight;
        }

        public void setMakeupWeight(BigDecimal makeupWeight) {
            this.makeupWeight = makeupWeight;
        }
    }
}
