-- 插入学习活动测试数据
-- 为现有学生添加学习活动记录

USE student_analysis_system;

-- 假设student ID=1存在,添加该学生的学习活动
-- 登录活动
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(1, NULL, 'LOGIN', NULL, 0, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, NULL, 'LOGIN', NULL, 0, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(1, NULL, 'LOGIN', NULL, 0, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(1, NULL, 'LOGIN', NULL, 0, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(1, NULL, 'LOGIN', NULL, 0, DATE_SUB(NOW(), INTERVAL 7 DAY));

-- 查看资料活动 (假设course ID=1存在)
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(1, 1, 'VIEW_MATERIAL', '{"title": "数据结构课件", "description": "第一章：线性表"}', 15, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, 1, 'VIEW_MATERIAL', '{"title": "算法分析视频", "description": "时间复杂度分析"}', 30, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(1, 1, 'VIEW_MATERIAL', '{"title": "习题解析", "description": "链表相关习题"}', 20, DATE_SUB(NOW(), INTERVAL 3 DAY));

-- 下载资料
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(1, 1, 'DOWNLOAD_MATERIAL', '{"title": "课程PPT", "fileSize": "2.5MB"}', 0, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(1, 1, 'DOWNLOAD_MATERIAL', '{"title": "实验指导书", "fileSize": "1.8MB"}', 0, DATE_SUB(NOW(), INTERVAL 4 DAY));

-- 提交作业
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(1, 1, 'SUBMIT_ASSIGNMENT', '{"title": "第一次作业", "description": "链表实现"}', 60, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(1, 1, 'SUBMIT_ASSIGNMENT', '{"title": "第二次作业", "description": "栈和队列应用"}', 45, DATE_SUB(NOW(), INTERVAL 6 DAY));

-- 查看成绩
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(1, 1, 'VIEW_GRADE', '{"examName": "期中考试", "score": 85}', 5, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, 1, 'VIEW_GRADE', '{"examName": "第一次测验", "score": 92}', 5, DATE_SUB(NOW(), INTERVAL 5 DAY));

-- 参加考试
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(1, 1, 'TAKE_EXAM', '{"examName": "期中考试", "questions": 20}', 90, DATE_SUB(NOW(), INTERVAL 4 DAY));

-- 观看视频
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(1, 1, 'WATCH_VIDEO', '{"title": "算法导论", "duration": "45分钟"}', 45, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, 1, 'WATCH_VIDEO', '{"title": "数据结构实战", "duration": "30分钟"}', 30, DATE_SUB(NOW(), INTERVAL 2 DAY));

-- 假设student ID=2存在
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(2, NULL, 'LOGIN', NULL, 0, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(2, 1, 'VIEW_MATERIAL', '{"title": "课程介绍", "description": "第一章概述"}', 10, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(2, 1, 'WATCH_VIDEO', '{"title": "入门教程", "duration": "20分钟"}', 20, DATE_SUB(NOW(), INTERVAL 3 HOUR));

-- 假设student ID=3存在
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration, created_at) VALUES
(3, NULL, 'LOGIN', NULL, 0, NOW()),
(3, 1, 'VIEW_MATERIAL', '{"title": "复习资料", "description": "考前复习"}', 25, DATE_SUB(NOW(), INTERVAL 30 MINUTE)),
(3, 1, 'SUBMIT_ASSIGNMENT', '{"title": "课程作业", "description": "算法实现"}', 50, DATE_SUB(NOW(), INTERVAL 1 HOUR));

-- 查询验证数据
SELECT 
    la.id,
    la.student_id,
    s.name as student_name,
    la.activity_type,
    la.duration,
    la.created_at
FROM learning_activities la
LEFT JOIN students s ON la.student_id = s.id
ORDER BY la.created_at DESC
LIMIT 20;

-- 统计每个学生的活动数量
SELECT 
    student_id,
    COUNT(*) as activity_count,
    SUM(duration) as total_minutes
FROM learning_activities
GROUP BY student_id;
