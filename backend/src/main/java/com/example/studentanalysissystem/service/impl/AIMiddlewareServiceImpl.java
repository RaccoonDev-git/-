package com.example.studentanalysissystem.service.impl;

import com.example.studentanalysissystem.service.AIMiddlewareService;
import com.example.studentanalysissystem.service.ai.AIModelAdapter;
import com.example.studentanalysissystem.dto.request.AIRequest;
import com.example.studentanalysissystem.dto.response.AIResponse;
import com.example.studentanalysissystem.service.StudentService;
import com.example.studentanalysissystem.service.TeacherService;
import com.example.studentanalysissystem.service.GradeService;
import com.example.studentanalysissystem.service.ResourceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * AI中间件服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AIMiddlewareServiceImpl implements AIMiddlewareService {
    
    private final List<AIModelAdapter> modelAdapters;
    private final StudentService studentService;
    private final TeacherService teacherService;
    private final GradeService gradeService;
    private final ResourceService resourceService;
    
    // 当前使用的模型适配器
    private AIModelAdapter currentAdapter;
    
    /**
     * 初始化AI中间件服务
     */
    @PostConstruct
    public void init() {
        log.info("初始化AI中间件服务，可用模型适配器数量: {}", modelAdapters.size());
        
        // 尝试设置默认模型为DeepSeek
        if (!modelAdapters.isEmpty()) {
            AIModelAdapter defaultAdapter = modelAdapters.stream()
                    .filter(adapter -> "DeepSeek Chat".equalsIgnoreCase(adapter.getModelName()))
                    .findFirst()
                    .orElse(modelAdapters.get(0)); // 如果没有找到DeepSeek，使用第一个可用模型
            
            if (defaultAdapter.isAvailable()) {
                this.currentAdapter = defaultAdapter;
                log.info("设置默认AI模型: {}", defaultAdapter.getModelName());
            } else {
                log.warn("默认AI模型 {} 不可用", defaultAdapter.getModelName());
            }
        } else {
            log.warn("没有找到任何AI模型适配器");
        }
    }
    
    @Override
    public AIResponse analyzeStudentLearning(Long userId, String analysisType) {
        try {
            // 根据用户ID获取学生信息
            var student = studentService.getStudentByUserId(userId);
            var scores = gradeService.getGradesByStudentId(student.getId());
            
            // 构建系统提示词
            String systemPrompt = buildLearningAnalysisSystemPrompt(analysisType);
            
            // 构建用户提示词
            String userPrompt = buildLearningAnalysisUserPrompt(student, scores, analysisType);
            
            // 创建AI请求
            AIRequest request = AIRequest.builder()
                    .requestId(UUID.randomUUID().toString())
                    .userId(userId)
                    .userRole("STUDENT")
                    .systemPrompt(systemPrompt)
                    .userPrompt(userPrompt)
                    .requestType("LEARNING_ANALYSIS")
                    .context(Map.of(
                            "userId", userId,
                            "studentId", student.getId(),
                            "analysisType", analysisType,
                            "scores", scores
                    ))
                    .build();
            
            return callAI(request);
            
        } catch (Exception e) {
            log.error("分析学生学习情况失败", e);
            return AIResponse.builder()
                    .success(false)
                    .error("分析失败: " + e.getMessage())
                    .timestamp(LocalDateTime.now())
                    .build();
        }
    }
    
    @Override
    public AIResponse recommendResources(Long userId, String resourceType) {
        try {
            // 根据用户ID获取学生信息
            var student = studentService.getStudentByUserId(userId);
            var scores = gradeService.getGradesByStudentId(student.getId());
            var resources = resourceService.getAllResources(); // 获取所有资源，前端可进一步筛选
            
            String systemPrompt = buildResourceRecommendationSystemPrompt();
            String userPrompt = buildResourceRecommendationUserPrompt(student, scores, resources, resourceType);
            
            AIRequest request = AIRequest.builder()
                    .requestId(UUID.randomUUID().toString())
                    .userId(userId)
                    .userRole("STUDENT")
                    .systemPrompt(systemPrompt)
                    .userPrompt(userPrompt)
                    .requestType("RESOURCE_RECOMMENDATION")
                    .context(Map.of(
                            "userId", userId,
                            "studentId", student.getId(),
                            "resourceType", resourceType,
                            "scores", scores,
                            "resources", resources
                    ))
                    .build();
            
            return callAI(request);
            
        } catch (Exception e) {
            log.error("推荐学习资源失败", e);
            return AIResponse.builder()
                    .success(false)
                    .error("推荐失败: " + e.getMessage())
                    .timestamp(LocalDateTime.now())
                    .build();
        }
    }
    
    @Override
    public AIResponse analyzeClassPerformance(Long teacherId, Long courseId) {
        try {
            // 获取班级数据
            var teacher = teacherService.getTeacherById(teacherId);
            var classStudents = studentService.getStudentsByClassName("班级1"); // 简化处理
            var classScores = gradeService.getGradesByCourseId(courseId);
            
            String systemPrompt = buildClassAnalysisSystemPrompt();
            String userPrompt = buildClassAnalysisUserPrompt(teacher, classStudents, classScores, courseId);
            
            AIRequest request = AIRequest.builder()
                    .requestId(UUID.randomUUID().toString())
                    .userId(teacherId)
                    .userRole("TEACHER")
                    .systemPrompt(systemPrompt)
                    .userPrompt(userPrompt)
                    .requestType("CLASS_ANALYSIS")
                    .context(Map.of(
                            "teacherId", teacherId,
                            "courseId", courseId,
                            "classStudents", classStudents,
                            "classScores", classScores
                    ))
                    .build();
            
            return callAI(request);
            
        } catch (Exception e) {
            log.error("分析班级表现失败", e);
            return AIResponse.builder()
                    .success(false)
                    .error("分析失败: " + e.getMessage())
                    .timestamp(LocalDateTime.now())
                    .build();
        }
    }
    
    @Override
    public AIResponse generateStudyAdvice(Long studentId, String context) {
        try {
            var student = studentService.getStudentById(studentId);
            var scores = gradeService.getGradesByStudentId(studentId);
            
            String systemPrompt = buildStudyAdviceSystemPrompt();
            String userPrompt = buildStudyAdviceUserPrompt(student, scores, context);
            
            AIRequest request = AIRequest.builder()
                    .requestId(UUID.randomUUID().toString())
                    .userId(studentId)
                    .userRole("STUDENT")
                    .systemPrompt(systemPrompt)
                    .userPrompt(userPrompt)
                    .requestType("STUDY_ADVICE")
                    .context(Map.of(
                            "studentId", studentId,
                            "context", context,
                            "scores", scores
                    ))
                    .build();
            
            return callAI(request);
            
        } catch (Exception e) {
            log.error("生成学习建议失败", e);
            return AIResponse.builder()
                    .success(false)
                    .error("生成建议失败: " + e.getMessage())
                    .timestamp(LocalDateTime.now())
                    .build();
        }
    }
    
    @Override
    public AIResponse chatWithAI(String message, String context, String userId) {
        try {
            String systemPrompt = buildChatSystemPrompt();
            String userPrompt = buildChatUserPrompt(message, context);
            
            AIRequest request = AIRequest.builder()
                    .requestId(UUID.randomUUID().toString())
                    .userId(Long.valueOf(userId))
                    .systemPrompt(systemPrompt)
                    .userPrompt(userPrompt)
                    .requestType("CHAT")
                    .context(Map.of(
                            "message", message,
                            "context", context
                    ))
                    .build();
            
            return callAI(request);
            
        } catch (Exception e) {
            log.error("AI对话失败", e);
            return AIResponse.builder()
                    .success(false)
                    .error("对话失败: " + e.getMessage())
                    .timestamp(LocalDateTime.now())
                    .build();
        }
    }
    
    @Override
    public boolean switchModel(String modelName) {
        AIModelAdapter adapter = modelAdapters.stream()
                .filter(a -> a.getModelName().equalsIgnoreCase(modelName))
                .findFirst()
                .orElse(null);
        
        if (adapter != null && adapter.isAvailable()) {
            this.currentAdapter = adapter;
            log.info("切换到模型: {}", modelName);
            return true;
        }
        
        log.warn("模型 {} 不可用", modelName);
        return false;
    }
    
    @Override
    public List<String> getAvailableModels() {
        return modelAdapters.stream()
                .filter(AIModelAdapter::isAvailable)
                .map(AIModelAdapter::getModelName)
                .collect(Collectors.toList());
    }
    
    /**
     * 调用AI模型
     */
    private AIResponse callAI(AIRequest request) {
        long startTime = System.currentTimeMillis();
        
        try {
            // 如果没有指定模型，使用默认模型
            if (currentAdapter == null) {
                currentAdapter = modelAdapters.stream()
                        .filter(AIModelAdapter::isAvailable)
                        .findFirst()
                        .orElse(null);
            }
            
            if (currentAdapter == null) {
                return AIResponse.builder()
                        .success(false)
                        .error("没有可用的AI模型")
                        .timestamp(LocalDateTime.now())
                        .build();
            }
            
            // 调用AI模型
            AIResponse response = currentAdapter.call(request);
            
            // 设置处理时间
            response.setProcessingTime(System.currentTimeMillis() - startTime);
            
            return response;
            
        } catch (Exception e) {
            log.error("调用AI模型失败", e);
            return AIResponse.builder()
                    .success(false)
                    .error("调用AI模型失败: " + e.getMessage())
                    .timestamp(LocalDateTime.now())
                    .processingTime(System.currentTimeMillis() - startTime)
                    .build();
        }
    }
    
    // 构建各种提示词的方法
    private String buildLearningAnalysisSystemPrompt(String analysisType) {
        return String.format("""
            你是一个专业的教学分析师。请根据学生的学习数据，进行%s分析。
            
            分析要求：
            1. 客观分析学生的优势与不足
            2. 识别学习模式和趋势
            3. 提供具体的改进建议
            4. 用简洁明了的语言表达
            5. 避免过于技术性的术语
            
            请以结构化的方式组织回答。
            """, analysisType);
    }
    
    private String buildLearningAnalysisUserPrompt(Object student, Object scores, String analysisType) {
        return String.format("""
            请分析以下学生的学习情况：
            
            学生信息：%s
            
            成绩数据：%s
            
            分析类型：%s
            
            请提供详细的分析报告。
            """, student, scores, analysisType);
    }
    
    private String buildResourceRecommendationSystemPrompt() {
        return """
            你是一个智能学习资源推荐专家。请根据学生的学习情况和需求，推荐合适的学习资源。
            
            推荐原则：
            1. 基于学生的学习水平和兴趣
            2. 考虑学生的薄弱环节
            3. 推荐多样化的资源类型
            4. 提供推荐理由
            5. 按优先级排序
            
            请以结构化的方式组织推荐结果。
            """;
    }
    
    private String buildResourceRecommendationUserPrompt(Object student, Object scores, Object resources, String resourceType) {
        return String.format("""
            请为以下学生推荐学习资源：
            
            学生信息：%s
            
            成绩情况：%s
            
            已用资源：%s
            
            资源类型偏好：%s
            
            请提供个性化的资源推荐。
            """, student, scores, resources, resourceType);
    }
    
    private String buildClassAnalysisSystemPrompt() {
        return """
            你是一个班级教学分析师。请分析班级整体的学习表现，为教师提供教学改进建议。
            
            分析重点：
            1. 班级整体水平评估
            2. 学生分层情况分析
            3. 教学效果评估
            4. 改进建议和策略
            5. 重点关注学生识别
            
            请提供实用的教学指导建议。
            """;
    }
    
    private String buildClassAnalysisUserPrompt(Object teacher, Object students, Object scores, Long courseId) {
        return String.format("""
            请分析以下班级的教学情况：
            
            教师信息：%s
            
            班级学生：%s
            
            成绩数据：%s
            
            课程ID：%s
            
            请提供班级分析报告。
            """, teacher, students, scores, courseId);
    }
    
    private String buildStudyAdviceSystemPrompt() {
        return """
            你是一个学习指导专家。请根据学生的具体情况，提供个性化的学习建议。
            
            指导原则：
            1. 针对性强，切合学生实际
            2. 方法具体可操作
            3. 循序渐进，逐步提升
            4. 鼓励为主，激发学习动力
            5. 注重学习习惯培养
            
            请提供实用的学习指导。
            """;
    }
    
    private String buildStudyAdviceUserPrompt(Object student, Object scores, String context) {
        return String.format("""
            请为以下学生提供学习建议：
            
            学生信息：%s
            
            成绩情况：%s
            
            具体情境：%s
            
            请提供针对性的学习建议。
            """, student, scores, context);
    }
    
    private String buildChatSystemPrompt() {
        return """
            你是一个智能教学助手，专门为学生和教师提供学习相关的帮助。
            
            助手特点：
            1. 友善耐心，乐于助人
            2. 知识丰富，解答准确
            3. 语言简洁，易于理解
            4. 鼓励学习，积极正面
            5. 专业可靠，值得信赖
            
            请以对话的方式回应用户的问题。
            """;
    }
    
    private String buildChatUserPrompt(String message, String context) {
        return String.format("""
            用户消息：%s
            
            上下文：%s
            
            请回复用户的问题。
            """, message, context);
    }
}
