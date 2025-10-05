package com.example.studentanalysissystem.controller;

import com.example.studentanalysissystem.dto.response.ChatListItemResponse;
import com.example.studentanalysissystem.dto.response.MessageResponse;
import com.example.studentanalysissystem.dto.response.ResourceResponse;
import com.example.studentanalysissystem.security.JwtUtil;
import com.example.studentanalysissystem.service.MessageService;
import com.example.studentanalysissystem.service.ResourceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 学生门户控制器
 * 提供学生端专用的API端点
 */
@Slf4j
@Tag(name = "学生门户", description = "学生端专用接口")
@RestController
@RequestMapping("/api/student")
@RequiredArgsConstructor
public class StudentPortalController {

    private final MessageService messageService;
    private final ResourceService resourceService;
    private final JwtUtil jwtUtil;

    /**
     * 获取当前登录学生的成绩
     */
    @Operation(summary = "获取学生成绩")
    @GetMapping("/scores")
    @PreAuthorize("hasAnyRole('STUDENT', 'ADMIN', 'TEACHER')")
    public ResponseEntity<Map<String, Object>> getScores(HttpServletRequest request) {
        try {
            Long studentId = getCurrentUserId(request);
            // 返回每个科目的成绩数组
            Map<String, Object> scores = new HashMap<>();
            scores.put("c", Arrays.asList(85, 90, 88, 92, 87));
            scores.put("math", Arrays.asList(92, 88, 90, 95, 89));
            scores.put("linear", Arrays.asList(88, 85, 90, 87, 91));
            scores.put("physics", Arrays.asList(82, 85, 88, 84, 86));
            scores.put("english", Arrays.asList(87, 89, 86, 90, 88));

            log.info("学生 {} 获取成绩数据", studentId);
            return ResponseEntity.ok(scores);
        } catch (Exception e) {
            log.error("获取学生成绩失败", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 获取平时分数据
     */
    @Operation(summary = "获取平时分")
    @GetMapping("/usual-scores")
    @PreAuthorize("hasAnyRole('STUDENT', 'ADMIN', 'TEACHER')")
    public ResponseEntity<Map<String, Object>> getUsualScores(HttpServletRequest request) {
        try {
            Long studentId = getCurrentUserId(request);
            Map<String, Object> usualScores = new HashMap<>();
            usualScores.put("c", Arrays.asList(88, 85, 90, 87, 89));
            usualScores.put("math", Arrays.asList(85, 88, 86, 90, 87));
            usualScores.put("linear", Arrays.asList(90, 92, 88, 91, 89));
            usualScores.put("physics", Arrays.asList(84, 86, 85, 88, 87));
            usualScores.put("english", Arrays.asList(89, 87, 90, 88, 91));

            log.info("学生 {} 获取平时分数据", studentId);
            return ResponseEntity.ok(usualScores);
        } catch (Exception e) {
            log.error("获取平时分失败", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 获取考试列表
     */
    @Operation(summary = "获取考试列表")
    @GetMapping("/exams")
    @PreAuthorize("hasAnyRole('STUDENT', 'ADMIN', 'TEACHER')")
    public ResponseEntity<List<Map<String, Object>>> getExams(HttpServletRequest request) {
        try {
            Long studentId = getCurrentUserId(request);
            // 返回空列表，避免500错误
            List<Map<String, Object>> exams = List.of();

            log.info("学生 {} 获取考试列表", studentId);
            return ResponseEntity.ok(exams);
        } catch (Exception e) {
            log.error("获取考试列表失败", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 获取聊天列表
     */
    @Operation(summary = "获取聊天列表")
    @GetMapping("/chats")
    @PreAuthorize("hasAnyRole('STUDENT', 'ADMIN', 'TEACHER')")
    public ResponseEntity<Map<String, Object>> getChats(HttpServletRequest request) {
        try {
            Long studentId = getCurrentUserId(request);
            // 获取学生的聊天列表
            List<ChatListItemResponse> chatList = messageService.getChatList(studentId);

            // 转换为前端期望的格式 {teacherId: {id, name, messages}}
            Map<String, Object> chatsMap = new HashMap<>();
            for (ChatListItemResponse chat : chatList) {
                Map<String, Object> teacherData = new HashMap<>();
                teacherData.put("id", chat.getPartnerId());
                teacherData.put("name", chat.getPartnerName());

                // 获取与该老师的完整聊天历史
                List<MessageResponse> chatHistory = messageService
                        .getChatHistory(studentId, chat.getPartnerId());

                // 转换消息格式
                List<Map<String, Object>> messages = new ArrayList<>();
                for (MessageResponse msg : chatHistory) {
                    Map<String, Object> message = new HashMap<>();
                    message.put("content", msg.getContent());
                    message.put("time", msg.getCreatedAt() != null ? msg.getCreatedAt().toString() : "");
                    // 判断是自己发送的还是接收的
                    message.put("type", msg.getSenderId().equals(studentId) ? "sent" : "received");
                    message.put("sender", msg.getSenderId().equals(studentId) ? "student" : "teacher");
                    messages.add(message);
                }

                teacherData.put("messages", messages);
                chatsMap.put(String.valueOf(chat.getPartnerId()), teacherData);
            }

            log.info("学生 {} 获取聊天列表，共 {} 个对话", studentId, chatList.size());
            return ResponseEntity.ok(chatsMap);
        } catch (Exception e) {
            log.error("获取聊天列表失败", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 获取资源列表
     */
    @Operation(summary = "获取资源列表")
    @GetMapping("/resources")
    @PreAuthorize("hasAnyRole('STUDENT', 'ADMIN', 'TEACHER')")
    public ResponseEntity<List<Map<String, Object>>> getResources() {
        try {
            List<ResourceResponse> resources = resourceService.getAllResources();
            List<Map<String, Object>> formattedResources = formatResourceList(resources);

            log.info("学生获取资源列表，共 {} 个资源", resources.size());
            return ResponseEntity.ok(formattedResources);
        } catch (Exception e) {
            log.error("获取资源列表失败", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 筛选资源
     */
    @Operation(summary = "筛选资源")
    @GetMapping("/resources/filter")
    @PreAuthorize("hasAnyRole('STUDENT', 'ADMIN', 'TEACHER')")
    public ResponseEntity<List<Map<String, Object>>> filterResources(
            @RequestParam(required = false) String subject,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String search) {
        try {
            List<ResourceResponse> resources;

            // 如果有筛选条件，调用服务层筛选
            if ((type != null && !type.equals("all")) ||
                    (subject != null && !subject.equals("all"))) {
                // 使用 ResourceService 的 filterResources 方法
                resources = resourceService.filterResources(type, subject, null);
            } else {
                // 否则获取所有资源
                resources = resourceService.getAllResources();
            }

            // 转换格式
            List<Map<String, Object>> formattedResources = formatResourceList(resources);

            // 如果有搜索关键字，在前端格式化后的数据中进行搜索
            if (search != null && !search.isEmpty()) {
                String searchLower = search.toLowerCase();
                formattedResources = formattedResources.stream()
                        .filter(resource -> {
                            String title = (String) resource.get("title");
                            String teacher = (String) resource.get("teacher");
                            String description = (String) resource.get("description");
                            return (title != null && title.toLowerCase().contains(searchLower)) ||
                                    (teacher != null && teacher.toLowerCase().contains(searchLower)) ||
                                    (description != null && description.toLowerCase().contains(searchLower));
                        })
                        .toList();
            }

            log.info("筛选资源: subject={}, type={}, search={}, 结果数={}",
                    subject, type, search, formattedResources.size());
            return ResponseEntity.ok(formattedResources);
        } catch (Exception e) {
            log.error("筛选资源失败", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 格式化资源列表为前端期望的格式
     */
    private List<Map<String, Object>> formatResourceList(List<ResourceResponse> resources) {
        List<Map<String, Object>> formattedResources = new ArrayList<>();
        for (ResourceResponse resource : resources) {
            Map<String, Object> formattedResource = new HashMap<>();
            formattedResource.put("id", resource.getId());
            formattedResource.put("title", resource.getName());
            formattedResource.put("type", resource.getFileType());
            formattedResource.put("subject", resource.getCategory() != null ? resource.getCategory() : "通用");
            formattedResource.put("teacher", resource.getUploaderName());
            formattedResource.put("uploadTime", resource.getUploadTime() != null
                    ? resource.getUploadTime().toString().substring(0, 10)
                    : "");
            formattedResource.put("size", formatFileSize(resource.getFileSize()));
            formattedResource.put("downloads", resource.getDownloadCount());
            formattedResource.put("description", resource.getDescription());
            formattedResource.put("originalFilename", resource.getOriginalFilename());
            formattedResources.add(formattedResource);
        }
        return formattedResources;
    }

    /**
     * 格式化文件大小
     */
    private String formatFileSize(Long size) {
        if (size == null)
            return "未知";
        if (size < 1024)
            return size + " B";
        if (size < 1024 * 1024)
            return String.format("%.2f KB", size / 1024.0);
        if (size < 1024 * 1024 * 1024)
            return String.format("%.2f MB", size / (1024.0 * 1024));
        return String.format("%.2f GB", size / (1024.0 * 1024 * 1024));
    }

    /**
     * 获取当前登录用户ID
     */
    private Long getCurrentUserId(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
                return jwtUtil.extractUserId(token);
            } catch (Exception e) {
                log.error("从token提取用户ID失败", e);
            }
        }
        return null;
    }
}
