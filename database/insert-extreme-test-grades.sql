-- 插入极端情况的成绩数据

-- 编译原理课程成绩（各种极端情况）
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A2班级 - 编译原理（优秀班级，高分多）
(26, 16, 1, 'FINAL', 98.00, 100.00, 98.00, 'A', '2024-06-15', 'Perfect student', NOW(), NOW()),
(27, 17, 1, 'FINAL', 95.00, 100.00, 95.00, 'A', '2024-06-15', 'Excellent student', NOW(), NOW()),
(28, 18, 1, 'FINAL', 92.00, 100.00, 92.00, 'A', '2024-06-15', NULL, NOW(), NOW()),
(29, 19, 1, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-15', NULL, NOW(), NOW()),
(30, 20, 1, 'FINAL', 86.00, 100.00, 86.00, 'B', '2024-06-15', NULL, NOW(), NOW()),

-- 18CS-A3班级 - 编译原理（困难班级，低分多）
(31, 21, 1, 'FINAL', 78.00, 100.00, 78.00, 'C', '2024-06-15', NULL, NOW(), NOW()),
(32, 22, 1, 'FINAL', 72.00, 100.00, 72.00, 'C', '2024-06-15', NULL, NOW(), NOW()),
(33, 23, 1, 'FINAL', 68.00, 100.00, 68.00, 'D', '2024-06-15', NULL, NOW(), NOW()),
(34, 24, 1, 'FINAL', 45.00, 100.00, 45.00, 'F', '2024-06-15', 'Needs makeup exam', NOW(), NOW()),
(35, 25, 1, 'FINAL', 35.00, 100.00, 35.00, 'F', '2024-06-15', 'Severely failing', NOW(), NOW()),

-- 数据结构课程成绩（极端高分和低分）
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A2班级 - 数据结构
(36, 16, 2, 'FINAL', 100.00, 100.00, 100.00, 'A', '2024-06-20', 'Perfect score', NOW(), NOW()),
(37, 17, 2, 'FINAL', 96.00, 100.00, 96.00, 'A', '2024-06-20', 'Excellent student', NOW(), NOW()),
(38, 18, 2, 'FINAL', 94.00, 100.00, 94.00, 'A', '2024-06-20', NULL, NOW(), NOW()),
(39, 19, 2, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-20', NULL, NOW(), NOW()),
(40, 20, 2, 'FINAL', 88.00, 100.00, 88.00, 'B', '2024-06-20', NULL, NOW(), NOW()),

-- 18CS-A3班级 - 数据结构
(41, 21, 2, 'FINAL', 79.00, 100.00, 79.00, 'C', '2024-06-20', NULL, NOW(), NOW()),
(42, 22, 2, 'FINAL', 73.00, 100.00, 73.00, 'C', '2024-06-20', NULL, NOW(), NOW()),
(43, 23, 2, 'FINAL', 69.00, 100.00, 69.00, 'D', '2024-06-20', NULL, NOW(), NOW()),
(44, 24, 2, 'FINAL', 38.00, 100.00, 38.00, 'F', '2024-06-20', 'Severely failing', NOW(), NOW()),
(45, 25, 2, 'FINAL', 28.00, 100.00, 28.00, 'F', '2024-06-20', 'Extremely poor', NOW(), NOW()),

-- 计算机基础课程成绩
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A2班级 - 计算机基础
(46, 16, 3, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-25', NULL, NOW(), NOW()),
(47, 17, 3, 'FINAL', 87.00, 100.00, 87.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(48, 18, 3, 'FINAL', 84.00, 100.00, 84.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(49, 19, 3, 'FINAL', 81.00, 100.00, 81.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(50, 20, 3, 'FINAL', 78.00, 100.00, 78.00, 'C', '2024-06-25', NULL, NOW(), NOW()),

-- 18CS-A3班级 - 计算机基础
(51, 21, 3, 'FINAL', 86.00, 100.00, 86.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(52, 22, 3, 'FINAL', 83.00, 100.00, 83.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(53, 23, 3, 'FINAL', 80.00, 100.00, 80.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(54, 24, 3, 'FINAL', 77.00, 100.00, 77.00, 'C', '2024-06-25', NULL, NOW(), NOW()),
(55, 25, 3, 'FINAL', 74.00, 100.00, 74.00, 'C', '2024-06-25', NULL, NOW(), NOW()),

-- 英语课程成绩（极端情况：大部分高分，少数极低分）
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A2班级 - 英语
(56, 16, 4, 'FINAL', 94.00, 100.00, 94.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(57, 17, 4, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(58, 18, 4, 'FINAL', 88.00, 100.00, 88.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(59, 19, 4, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(60, 20, 4, 'FINAL', 82.00, 100.00, 82.00, 'B', '2024-06-30', NULL, NOW(), NOW()),

-- 18CS-A3班级 - 英语
(61, 21, 4, 'FINAL', 90.00, 100.00, 90.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(62, 22, 4, 'FINAL', 87.00, 100.00, 87.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(63, 23, 4, 'FINAL', 84.00, 100.00, 84.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(64, 24, 4, 'FINAL', 15.00, 100.00, 15.00, 'F', '2024-06-30', 'Extremely poor English', NOW(), NOW()),
(65, 25, 4, 'FINAL', 12.00, 100.00, 12.00, 'F', '2024-06-30', 'Cannot speak English', NOW(), NOW()),

-- 其他班级的成绩数据
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 19CS-A2班级 - 编译原理
(66, 26, 1, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-10', NULL, NOW(), NOW()),
(67, 27, 1, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-10', NULL, NOW(), NOW()),
(68, 28, 1, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-10', NULL, NOW(), NOW()),
(69, 29, 1, 'FINAL', 87.00, 100.00, 87.00, 'B', '2024-06-10', NULL, NOW(), NOW()),
(70, 30, 1, 'FINAL', 83.00, 100.00, 83.00, 'B', '2024-06-10', NULL, NOW(), NOW()),

-- 20CS-A1班级 - 数据结构
(71, 31, 2, 'FINAL', 93.00, 100.00, 93.00, 'A', '2024-06-12', NULL, NOW(), NOW()),
(72, 32, 2, 'FINAL', 88.00, 100.00, 88.00, 'B', '2024-06-12', NULL, NOW(), NOW()),
(73, 33, 2, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-12', NULL, NOW(), NOW()),
(74, 34, 2, 'FINAL', 82.00, 100.00, 82.00, 'B', '2024-06-12', NULL, NOW(), NOW()),
(75, 35, 2, 'FINAL', 79.00, 100.00, 79.00, 'C', '2024-06-12', NULL, NOW(), NOW()),

-- 软件工程专业 - 计算机基础
(76, 36, 3, 'FINAL', 95.00, 100.00, 95.00, 'A', '2024-06-18', NULL, NOW(), NOW()),
(77, 37, 3, 'FINAL', 92.00, 100.00, 92.00, 'A', '2024-06-18', NULL, NOW(), NOW()),
(78, 38, 3, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-18', NULL, NOW(), NOW()),
(79, 39, 3, 'FINAL', 86.00, 100.00, 86.00, 'B', '2024-06-18', NULL, NOW(), NOW()),
(80, 40, 3, 'FINAL', 83.00, 100.00, 83.00, 'B', '2024-06-18', NULL, NOW(), NOW()),

-- 信息安全专业 - 英语
(81, 41, 4, 'FINAL', 78.00, 100.00, 78.00, 'C', '2024-06-22', NULL, NOW(), NOW()),
(82, 42, 4, 'FINAL', 74.00, 100.00, 74.00, 'C', '2024-06-22', NULL, NOW(), NOW()),
(83, 43, 4, 'FINAL', 71.00, 100.00, 71.00, 'C', '2024-06-22', NULL, NOW(), NOW()),
(84, 44, 4, 'FINAL', 68.00, 100.00, 68.00, 'D', '2024-06-22', NULL, NOW(), NOW()),
(85, 45, 4, 'FINAL', 25.00, 100.00, 25.00, 'F', '2024-06-22', 'Very poor English', NOW(), NOW());
