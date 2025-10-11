-- 示范数据导入脚本
-- 基于真实编译原理课程数据和学生信息

-- 插入教师数据
INSERT INTO teachers (id, username, password, name, email, phone, department, title, created_at, updated_at) VALUES
(1, 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', '系统管理员', 'admin@example.com', '13800000000', '计算机与信息工程学院', '教授', NOW(), NOW()),
(2, 'teacher1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', '王娜', 'wangna@example.com', '13800000001', '计算机与信息工程学院', '副教授', NOW(), NOW()),
(3, 'teacher2', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', '李教授', 'li@example.com', '13800000002', '计算机与信息工程学院', '教授', NOW(), NOW());

-- 插入课程数据
INSERT INTO courses (id, name, code, description, credits, department, created_at, updated_at) VALUES
(1, '编译原理', 'CS301', '编译原理（软件工程、计算机科学与技术）', 3, '计算机与信息工程学院', NOW(), NOW()),
(2, '数据结构', 'CS201', '数据结构与算法', 4, '计算机与信息工程学院', NOW(), NOW()),
(3, '计算机基础', 'CS101', '计算机基础', 2, '计算机与信息工程学院', NOW(), NOW()),
(4, '英语', 'EN101', '大学英语', 2, '外国语学院', NOW(), NOW());

-- 插入学生数据（基于真实数据）
INSERT INTO students (id, student_id, name, email, phone, major, class_name, grade, enrollment_date, created_at, updated_at) VALUES
(1, '20181112737', '沈罡', 'shengang@example.com', '13800138001', '软件工程', '18软工A1', 2018, '2018-09-01', NOW(), NOW()),
(2, '20191111504', '贾阳', 'jiayang@example.com', '13800138002', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(3, '20191112403', '王一成', 'wangyicheng@example.com', '13800138003', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(4, '20191112404', '孟家豪', 'mengjiahao@example.com', '13800138004', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(5, '20191112405', '黄李栓', 'huanglishuan@example.com', '13800138005', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(6, '20191112406', '张明', 'zhangming@example.com', '13800138006', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(7, '20191112407', '李华', 'lihua@example.com', '13800138007', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(8, '20191112408', '王强', 'wangqiang@example.com', '13800138008', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(9, '20191112409', '刘洋', 'liuyang@example.com', '13800138009', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW()),
(10, '20191112410', '陈静', 'chenjing@example.com', '13800138010', '软件工程', '19软工A1', 2019, '2019-09-01', NOW(), NOW());

-- 插入课程选课关系
INSERT INTO course_enrollments (student_id, course_id, semester, academic_year, created_at) VALUES
-- 编译原理课程
(1, 1, '2024春季', '2023-2024', NOW()),
(2, 1, '2024春季', '2023-2024', NOW()),
(3, 1, '2024春季', '2023-2024', NOW()),
(4, 1, '2024春季', '2023-2024', NOW()),
(5, 1, '2024春季', '2023-2024', NOW()),
(6, 1, '2024春季', '2023-2024', NOW()),
(7, 1, '2024春季', '2023-2024', NOW()),
(8, 1, '2024春季', '2023-2024', NOW()),
(9, 1, '2024春季', '2023-2024', NOW()),
(10, 1, '2024春季', '2023-2024', NOW()),

-- 数据结构课程
(1, 2, '2024春季', '2023-2024', NOW()),
(2, 2, '2024春季', '2023-2024', NOW()),
(3, 2, '2024春季', '2023-2024', NOW()),
(4, 2, '2024春季', '2023-2024', NOW()),
(5, 2, '2024春季', '2023-2024', NOW()),

-- 计算机基础课程
(6, 3, '2024春季', '2023-2024', NOW()),
(7, 3, '2024春季', '2023-2024', NOW()),
(8, 3, '2024春季', '2023-2024', NOW()),
(9, 3, '2024春季', '2023-2024', NOW()),
(10, 3, '2024春季', '2023-2024', NOW()),

-- 英语课程
(1, 4, '2024春季', '2023-2024', NOW()),
(2, 4, '2024春季', '2023-2024', NOW()),
(3, 4, '2024春季', '2023-2024', NOW()),
(4, 4, '2024春季', '2023-2024', NOW()),
(5, 4, '2024春季', '2023-2024', NOW());

-- 插入成绩数据（基于真实学习情况）
INSERT INTO grades (id, student_id, course_id, score, grade_type, semester, academic_year, created_at, updated_at) VALUES
-- 编译原理成绩
(1, 1, 1, 65.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(2, 2, 1, 78.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(3, 3, 1, 85.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(4, 4, 1, 72.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(5, 5, 1, 88.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(6, 6, 1, 76.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(7, 7, 1, 82.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(8, 8, 1, 69.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(9, 9, 1, 91.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(10, 10, 1, 74.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),

-- 数据结构成绩
(11, 1, 2, 88.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(12, 2, 2, 92.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(13, 3, 2, 85.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(14, 4, 2, 78.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(15, 5, 2, 95.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),

-- 计算机基础成绩
(16, 6, 3, 82.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(17, 7, 3, 76.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(18, 8, 3, 89.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(19, 9, 3, 84.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(20, 10, 3, 91.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),

-- 英语成绩
(21, 1, 4, 85.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(22, 2, 4, 78.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(23, 3, 4, 92.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(24, 4, 4, 88.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW()),
(25, 5, 4, 86.0, 'FINAL', '2024春季', '2023-2024', NOW(), NOW());

-- 插入课程权重配置
INSERT INTO course_weight_configs (id, course_id, exam_weight, usual_weight, pass_score, make_up_exam_weight, is_active, created_at, updated_at) VALUES
(1, 1, 60.00, 40.00, 60.00, 70.00, true, NOW(), NOW()),
(2, 2, 70.00, 30.00, 60.00, 70.00, true, NOW(), NOW()),
(3, 3, 50.00, 50.00, 60.00, 70.00, true, NOW(), NOW()),
(4, 4, 80.00, 20.00, 60.00, 70.00, true, NOW(), NOW());

-- 插入成绩类型配置
INSERT INTO grade_types (id, type_name, type_code, is_regular, is_final, is_makeup, default_weight, full_score, is_active, sort_order, created_at, updated_at) VALUES
(1, '出勤率', 'ATTENDANCE', true, false, false, 20.00, 100.00, true, 1, NOW(), NOW()),
(2, '平时作业', 'HOMEWORK', true, false, false, 30.00, 100.00, true, 2, NOW(), NOW()),
(3, '实验报告', 'LAB', true, false, false, 25.00, 100.00, true, 3, NOW(), NOW()),
(4, '随堂测试', 'QUIZ', true, false, false, 25.00, 100.00, true, 4, NOW(), NOW()),
(5, '期末考试', 'FINAL', false, true, false, 100.00, 100.00, true, 5, NOW(), NOW()),
(6, '补考', 'MAKEUP', false, false, true, 100.00, 100.00, true, 6, NOW(), NOW());

-- 插入综合成绩数据
INSERT INTO comprehensive_grades (id, student_id, course_id, regular_score, final_score, makeup_score, comprehensive_score, final_grade, grade_level, is_passed, has_makeup, semester, academic_year, created_at, updated_at) VALUES
-- 编译原理综合成绩
(1, 1, 1, 68.0, 65.0, NULL, 66.2, 66.2, 'D', false, false, '2024春季', '2023-2024', NOW(), NOW()),
(2, 2, 1, 82.0, 78.0, NULL, 79.6, 79.6, 'C+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(3, 3, 1, 88.0, 85.0, NULL, 86.2, 86.2, 'B+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(4, 4, 1, 75.0, 72.0, NULL, 73.2, 73.2, 'C', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(5, 5, 1, 92.0, 88.0, NULL, 89.6, 89.6, 'A-', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(6, 6, 1, 79.0, 76.0, NULL, 77.2, 77.2, 'C+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(7, 7, 1, 85.0, 82.0, NULL, 83.2, 83.2, 'B', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(8, 8, 1, 72.0, 69.0, 75.0, 70.2, 75.0, 'C', true, true, '2024春季', '2023-2024', NOW(), NOW()),
(9, 9, 1, 94.0, 91.0, NULL, 92.2, 92.2, 'A', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(10, 10, 1, 77.0, 74.0, NULL, 75.2, 75.2, 'C+', true, false, '2024春季', '2023-2024', NOW(), NOW()),

-- 数据结构综合成绩
(11, 1, 2, 85.0, 88.0, NULL, 86.5, 86.5, 'B+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(12, 2, 2, 90.0, 92.0, NULL, 91.0, 91.0, 'A-', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(13, 3, 2, 82.0, 85.0, NULL, 83.5, 83.5, 'B', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(14, 4, 2, 75.0, 78.0, NULL, 76.5, 76.5, 'C+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(15, 5, 2, 96.0, 95.0, NULL, 95.3, 95.3, 'A', true, false, '2024春季', '2023-2024', NOW(), NOW()),

-- 计算机基础综合成绩
(16, 6, 3, 80.0, 82.0, NULL, 81.0, 81.0, 'B-', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(17, 7, 3, 73.0, 76.0, NULL, 74.5, 74.5, 'C', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(18, 8, 3, 87.0, 89.0, NULL, 88.0, 88.0, 'B+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(19, 9, 3, 81.0, 84.0, NULL, 82.5, 82.5, 'B-', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(20, 10, 3, 89.0, 91.0, NULL, 90.0, 90.0, 'A-', true, false, '2024春季', '2023-2024', NOW(), NOW()),

-- 英语综合成绩
(21, 1, 4, 82.0, 85.0, NULL, 84.0, 84.0, 'B', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(22, 2, 4, 75.0, 78.0, NULL, 76.8, 76.8, 'C+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(23, 3, 4, 90.0, 92.0, NULL, 91.2, 91.2, 'A-', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(24, 4, 4, 86.0, 88.0, NULL, 87.2, 87.2, 'B+', true, false, '2024春季', '2023-2024', NOW(), NOW()),
(25, 5, 4, 84.0, 86.0, NULL, 85.2, 85.2, 'B', true, false, '2024春季', '2023-2024', NOW(), NOW());

-- 插入学生预警数据
INSERT INTO student_warnings (id, student_id, course_id, warning_type, warning_level, title, content, current_regular_score, warning_threshold, is_handled, handled_at, handled_by, handle_remarks, semester, academic_year, created_at, updated_at) VALUES
(1, 1, 1, 'ATTENDANCE', 'HIGH', '出勤率过低', '学生沈罡在编译原理课程中出勤率仅为65%，需要重点关注', 65.0, 70.0, false, NULL, NULL, NULL, '2024春季', '2023-2024', NOW(), NOW()),
(2, 8, 1, 'REGULAR_SCORE', 'MEDIUM', '平时分偏低', '学生王强在编译原理课程中平时分仅为72%，建议提醒', 72.0, 75.0, false, NULL, NULL, NULL, '2024春季', '2023-2024', NOW(), NOW()),
(3, 10, 1, 'COMPREHENSIVE', 'LOW', '综合成绩偏低', '学生陈静在编译原理课程中综合成绩为75.2%，接近及格线', 75.2, 80.0, false, NULL, NULL, NULL, '2024春季', '2023-2024', NOW(), NOW());

-- 插入学习活动数据
INSERT INTO learning_activities (id, student_id, course_id, activity_type, activity_name, description, score, max_score, activity_date, created_at, updated_at) VALUES
(1, 1, 1, 'HOMEWORK', '编译系统概论作业', '完成编译系统概论相关作业', 65.0, 100.0, '2024-02-15', NOW(), NOW()),
(2, 2, 1, 'HOMEWORK', '词法分析作业', '完成词法分析相关作业', 78.0, 100.0, '2024-02-20', NOW(), NOW()),
(3, 3, 1, 'LAB', '语法分析实验', '完成语法分析实验报告', 85.0, 100.0, '2024-03-01', NOW(), NOW()),
(4, 4, 1, 'QUIZ', '随堂测试1', '词法分析随堂测试', 72.0, 100.0, '2024-03-05', NOW(), NOW()),
(5, 5, 1, 'HOMEWORK', '语法制导翻译作业', '完成语法制导翻译相关作业', 88.0, 100.0, '2024-03-10', NOW(), NOW());

-- 插入消息数据
INSERT INTO messages (id, sender_id, receiver_id, title, content, message_type, is_read, created_at, updated_at) VALUES
(1, 2, 1, '编译原理课程提醒', '请及时完成编译系统概论作业', 'COURSE', false, NOW(), NOW()),
(2, 2, 8, '出勤率提醒', '您的出勤率偏低，请及时关注课程学习', 'WARNING', false, NOW(), NOW()),
(3, 2, 10, '成绩提醒', '您的综合成绩接近及格线，请加强学习', 'GRADE', false, NOW(), NOW());

-- 插入资源数据
INSERT INTO resources (id, course_id, title, description, file_path, file_type, file_size, uploader_id, is_active, created_at, updated_at) VALUES
(1, 1, '编译原理课件第1章', '编译系统概论课件', '/uploads/compiler_chapter1.pdf', 'PDF', 2048000, 2, true, NOW(), NOW()),
(2, 1, '词法分析实验指导', '词法分析实验指导书', '/uploads/lexical_analysis_lab.pdf', 'PDF', 1536000, 2, true, NOW(), NOW()),
(3, 2, '数据结构算法实现', '数据结构算法实现代码', '/uploads/data_structure_code.zip', 'ZIP', 5120000, 2, true, NOW(), NOW());

SELECT '示范数据导入完成' as message;