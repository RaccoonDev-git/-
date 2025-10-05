-- =============================================
-- 插入测试数据
-- 学生学习情况分析系统
-- =============================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

USE student_analysis;

-- 清空现有数据 (谨慎使用!)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE learning_activities;
TRUNCATE TABLE notifications;
TRUNCATE TABLE grades;
TRUNCATE TABLE course_enrollments;
TRUNCATE TABLE courses;
TRUNCATE TABLE teachers;
TRUNCATE TABLE students;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- 1. 插入用户数据
-- 密码都是: password123 (已使用 BCrypt 加密)
-- BCrypt 哈希: $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
-- =============================================

-- 管理员用户
INSERT INTO users (username, password, role, email, phone, status) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ADMIN', 'admin@school.com', '13800000000', 'ACTIVE');

-- 教师用户
INSERT INTO users (username, password, role, email, phone, status) VALUES
('teacher1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'TEACHER', 'teacher1@school.com', '13800000001', 'ACTIVE'),
('teacher2', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'TEACHER', 'teacher2@school.com', '13800000002', 'ACTIVE'),
('teacher3', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'TEACHER', 'teacher3@school.com', '13800000003', 'ACTIVE');

-- 学生用户
INSERT INTO users (username, password, role, email, phone, status) VALUES
('student1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT', 'student1@school.com', '13900000001', 'ACTIVE'),
('student2', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT', 'student2@school.com', '13900000002', 'ACTIVE'),
('student3', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT', 'student3@school.com', '13900000003', 'ACTIVE'),
('student4', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT', 'student4@school.com', '13900000004', 'ACTIVE'),
('student5', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT', 'student5@school.com', '13900000005', 'ACTIVE');

-- =============================================
-- 2. 插入教师详细信息
-- =============================================

INSERT INTO teachers (user_id, name, employee_number, department, title, education, specialization, hire_date) VALUES
(2, '张老师', 'T001', '计算机学院', '教授', '博士', '数据结构与算法', '2015-09-01'),
(3, '李老师', 'T002', '计算机学院', '副教授', '硕士', '数据库系统', '2017-03-01'),
(4, '王老师', 'T003', '数学学院', '讲师', '硕士', '高等数学', '2019-09-01');

-- =============================================
-- 3. 插入学生详细信息
-- =============================================

INSERT INTO students (user_id, name, student_number, class, grade_level, major, enrollment_date) VALUES
(5, '陈同学', '2021001', '计算机2101', 3, '计算机科学与技术', '2021-09-01'),
(6, '刘同学', '2021002', '计算机2101', 3, '计算机科学与技术', '2021-09-01'),
(7, '赵同学', '2022001', '计算机2201', 2, '计算机科学与技术', '2022-09-01'),
(8, '孙同学', '2022002', '软件2201', 2, '软件工程', '2022-09-01'),
(9, '周同学', '2023001', '计算机2301', 1, '计算机科学与技术', '2023-09-01');

-- =============================================
-- 4. 插入课程信息
-- =============================================

INSERT INTO courses (name, code, teacher_id, description, credits, hours, semester, academic_year, capacity, status) VALUES
('数据结构', 'CS101', 1, '介绍常用数据结构和算法,包括线性表、树、图等', 4.0, 64, '第一学期', '2024-2025', 120, 'ACTIVE'),
('数据库系统', 'CS201', 2, '关系数据库理论与应用,SQL语言,数据库设计', 3.5, 56, '第一学期', '2024-2025', 100, 'ACTIVE'),
('高等数学', 'MATH101', 3, '微积分基础、极限、导数、积分', 5.0, 80, '第一学期', '2024-2025', 150, 'ACTIVE'),
('算法分析', 'CS301', 1, '算法设计与分析,动态规划,贪心算法', 4.0, 64, '第二学期', '2024-2025', 80, 'ACTIVE'),
('操作系统', 'CS202', 2, '操作系统原理,进程管理,内存管理', 4.0, 64, '第二学期', '2024-2025', 100, 'ACTIVE');

-- =============================================
-- 5. 插入选课记录
-- =============================================

-- 陈同学的选课
INSERT INTO course_enrollments (student_id, course_id, status) VALUES
(1, 1, 'COMPLETED'), -- 数据结构
(1, 2, 'COMPLETED'), -- 数据库系统
(1, 3, 'COMPLETED'), -- 高等数学
(1, 4, 'ENROLLED'),  -- 算法分析
(1, 5, 'ENROLLED');  -- 操作系统

-- 刘同学的选课
INSERT INTO course_enrollments (student_id, course_id, status) VALUES
(2, 1, 'COMPLETED'),
(2, 2, 'ENROLLED'),
(2, 3, 'COMPLETED');

-- 赵同学的选课
INSERT INTO course_enrollments (student_id, course_id, status) VALUES
(3, 1, 'ENROLLED'),
(3, 2, 'ENROLLED'),
(3, 3, 'COMPLETED');

-- 孙同学的选课
INSERT INTO course_enrollments (student_id, course_id, status) VALUES
(4, 1, 'ENROLLED'),
(4, 3, 'COMPLETED');

-- 周同学的选课
INSERT INTO course_enrollments (student_id, course_id, status) VALUES
(5, 3, 'ENROLLED');

-- =============================================
-- 6. 插入成绩数据
-- =============================================

-- 陈同学的成绩 (优秀学生)
INSERT INTO grades (student_id, course_id, exam_type, score, max_score, percentage, grade_level, exam_date) VALUES
(1, 1, '期中考试', 88.0, 100, 88.0, 'B', '2024-05-15'),
(1, 1, '期末考试', 92.0, 100, 92.0, 'A', '2024-07-10'),
(1, 1, '平时作业', 95.0, 100, 95.0, 'A', '2024-06-20'),
(1, 2, '期中考试', 85.0, 100, 85.0, 'B', '2024-05-20'),
(1, 2, '期末考试', 90.0, 100, 90.0, 'A', '2024-07-15'),
(1, 3, '期中考试', 78.0, 100, 78.0, 'C', '2024-05-10'),
(1, 3, '期末考试', 82.0, 100, 82.0, 'B', '2024-07-05');

-- 刘同学的成绩 (中等学生)
INSERT INTO grades (student_id, course_id, exam_type, score, max_score, percentage, grade_level, exam_date) VALUES
(2, 1, '期中考试', 75.0, 100, 75.0, 'C', '2024-05-15'),
(2, 1, '期末考试', 80.0, 100, 80.0, 'B', '2024-07-10'),
(2, 3, '期中考试', 70.0, 100, 70.0, 'C', '2024-05-10'),
(2, 3, '期末考试', 75.0, 100, 75.0, 'C', '2024-07-05');

-- 赵同学的成绩
INSERT INTO grades (student_id, course_id, exam_type, score, max_score, percentage, grade_level, exam_date) VALUES
(3, 3, '期中考试', 82.0, 100, 82.0, 'B', '2024-05-10'),
(3, 3, '期末考试', 88.0, 100, 88.0, 'B', '2024-07-05');

-- 孙同学的成绩
INSERT INTO grades (student_id, course_id, exam_type, score, max_score, percentage, grade_level, exam_date) VALUES
(4, 3, '期中考试', 65.0, 100, 65.0, 'D', '2024-05-10'),
(4, 3, '期末考试', 70.0, 100, 70.0, 'C', '2024-07-05');

-- =============================================
-- 7. 插入学习活动记录
-- =============================================

-- 陈同学的学习活动 (活跃学生)
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration) VALUES
(1, 1, 'LOGIN', '{"ip": "192.168.1.100", "device": "Windows"}', 0),
(1, 1, 'VIEW_MATERIAL', '{"material": "第一章课件", "chapter": 1}', 1200),
(1, 1, 'SUBMIT_ASSIGNMENT', '{"assignment": "作业1", "score": 95}', 3600),
(1, 2, 'LOGIN', '{"ip": "192.168.1.100", "device": "Windows"}', 0),
(1, 2, 'VIEW_MATERIAL', '{"material": "SQL基础", "chapter": 2}', 1800),
(1, 2, 'TAKE_QUIZ', '{"quiz": "测验1", "score": 90}', 1200);

-- 刘同学的学习活动 (中等活跃)
INSERT INTO learning_activities (student_id, course_id, activity_type, activity_data, duration) VALUES
(2, 1, 'LOGIN', '{"ip": "192.168.1.101", "device": "Mac"}', 0),
(2, 1, 'VIEW_MATERIAL', '{"material": "第一章课件", "chapter": 1}', 900),
(2, 3, 'VIEW_MATERIAL', '{"material": "微积分", "chapter": 1}', 600);

-- =============================================
-- 8. 插入通知信息
-- =============================================

INSERT INTO notifications (user_id, title, content, type, is_read) VALUES
(5, '新成绩发布', '您的数据结构期末考试成绩已发布,请查看', 'GRADE', FALSE),
(5, '选课通知', '下学期选课系统将于下周一开放', 'COURSE', FALSE),
(5, '系统维护通知', '系统将于本周六进行维护,届时无法访问', 'SYSTEM', TRUE),
(6, '作业提醒', '数据结构作业2即将截止,请及时提交', 'COURSE', FALSE),
(7, '成绩公布', '高等数学期末成绩已公布', 'GRADE', FALSE);

-- =============================================
-- 数据插入完成
-- =============================================

SELECT '测试数据插入完成!' as message;
SELECT COUNT(*) as user_count FROM users;
SELECT COUNT(*) as teacher_count FROM teachers;
SELECT COUNT(*) as student_count FROM students;
SELECT COUNT(*) as course_count FROM courses;
SELECT COUNT(*) as enrollment_count FROM course_enrollments;
SELECT COUNT(*) as grade_count FROM grades;
SELECT COUNT(*) as activity_count FROM learning_activities;
SELECT COUNT(*) as notification_count FROM notifications;
