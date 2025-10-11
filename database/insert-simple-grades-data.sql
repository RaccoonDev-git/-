-- Insert extreme grades data with English remarks only
-- This creates various extreme scenarios for testing

-- Compiler Principles grades (various extreme cases)
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A1 class - Compiler Principles
(26, 11, 1, 'FINAL', 95.00, 100.00, 95.00, 'A', '2024-06-15', 'Excellent student', NOW(), NOW()),
(27, 12, 1, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-15', NULL, NOW(), NOW()),
(28, 13, 1, 'FINAL', 75.00, 100.00, 75.00, 'C', '2024-06-15', NULL, NOW(), NOW()),
(29, 14, 1, 'FINAL', 65.00, 100.00, 65.00, 'D', '2024-06-15', NULL, NOW(), NOW()),
(30, 15, 1, 'FINAL', 45.00, 100.00, 45.00, 'F', '2024-06-15', 'Needs makeup exam', NOW(), NOW()),

-- 18CS-A2 class - Compiler Principles (higher average)
(31, 16, 1, 'FINAL', 92.00, 100.00, 92.00, 'A', '2024-06-15', NULL, NOW(), NOW()),
(32, 17, 1, 'FINAL', 88.00, 100.00, 88.00, 'B', '2024-06-15', NULL, NOW(), NOW()),
(33, 18, 1, 'FINAL', 90.00, 100.00, 90.00, 'A', '2024-06-15', NULL, NOW(), NOW()),
(34, 19, 1, 'FINAL', 86.00, 100.00, 86.00, 'B', '2024-06-15', NULL, NOW(), NOW()),
(35, 20, 1, 'FINAL', 84.00, 100.00, 84.00, 'B', '2024-06-15', NULL, NOW(), NOW()),

-- 18CS-A3 class - Compiler Principles (lower average)
(36, 21, 1, 'FINAL', 78.00, 100.00, 78.00, 'C', '2024-06-15', NULL, NOW(), NOW()),
(37, 22, 1, 'FINAL', 72.00, 100.00, 72.00, 'C', '2024-06-15', NULL, NOW(), NOW()),
(38, 23, 1, 'FINAL', 68.00, 100.00, 68.00, 'D', '2024-06-15', NULL, NOW(), NOW()),
(39, 24, 1, 'FINAL', 55.00, 100.00, 55.00, 'F', '2024-06-15', 'Needs makeup exam', NOW(), NOW()),
(40, 25, 1, 'FINAL', 52.00, 100.00, 52.00, 'F', '2024-06-15', 'Needs makeup exam', NOW(), NOW()),

-- Data Structure grades (extreme high and low scores)
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A1 class - Data Structure
(41, 11, 2, 'FINAL', 98.00, 100.00, 98.00, 'A', '2024-06-20', 'Perfect student', NOW(), NOW()),
(42, 12, 2, 'FINAL', 96.00, 100.00, 96.00, 'A', '2024-06-20', 'Excellent student', NOW(), NOW()),
(43, 13, 2, 'FINAL', 82.00, 100.00, 82.00, 'B', '2024-06-20', NULL, NOW(), NOW()),
(44, 14, 2, 'FINAL', 76.00, 100.00, 76.00, 'C', '2024-06-20', NULL, NOW(), NOW()),
(45, 15, 2, 'FINAL', 35.00, 100.00, 35.00, 'F', '2024-06-20', 'Severely failing', NOW(), NOW()),

-- 18CS-A2 class - Data Structure
(46, 16, 2, 'FINAL', 94.00, 100.00, 94.00, 'A', '2024-06-20', NULL, NOW(), NOW()),
(47, 17, 2, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-20', NULL, NOW(), NOW()),
(48, 18, 2, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-20', NULL, NOW(), NOW()),
(49, 19, 2, 'FINAL', 87.00, 100.00, 87.00, 'B', '2024-06-20', NULL, NOW(), NOW()),
(50, 20, 2, 'FINAL', 83.00, 100.00, 83.00, 'B', '2024-06-20', NULL, NOW(), NOW()),

-- 18CS-A3 class - Data Structure
(51, 21, 2, 'FINAL', 79.00, 100.00, 79.00, 'C', '2024-06-20', NULL, NOW(), NOW()),
(52, 22, 2, 'FINAL', 73.00, 100.00, 73.00, 'C', '2024-06-20', NULL, NOW(), NOW()),
(53, 23, 2, 'FINAL', 69.00, 100.00, 69.00, 'D', '2024-06-20', NULL, NOW(), NOW()),
(54, 24, 2, 'FINAL', 58.00, 100.00, 58.00, 'F', '2024-06-20', 'Needs makeup exam', NOW(), NOW()),
(55, 25, 2, 'FINAL', 41.00, 100.00, 41.00, 'F', '2024-06-20', 'Severely failing', NOW(), NOW()),

-- Computer Basics grades (normal distribution)
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A1 class - Computer Basics
(56, 11, 3, 'FINAL', 88.00, 100.00, 88.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(57, 12, 3, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(58, 13, 3, 'FINAL', 82.00, 100.00, 82.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(59, 14, 3, 'FINAL', 79.00, 100.00, 79.00, 'C', '2024-06-25', NULL, NOW(), NOW()),
(60, 15, 3, 'FINAL', 76.00, 100.00, 76.00, 'C', '2024-06-25', NULL, NOW(), NOW()),

-- 18CS-A2 class - Computer Basics
(61, 16, 3, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-25', NULL, NOW(), NOW()),
(62, 17, 3, 'FINAL', 87.00, 100.00, 87.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(63, 18, 3, 'FINAL', 84.00, 100.00, 84.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(64, 19, 3, 'FINAL', 81.00, 100.00, 81.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(65, 20, 3, 'FINAL', 78.00, 100.00, 78.00, 'C', '2024-06-25', NULL, NOW(), NOW()),

-- 18CS-A3 class - Computer Basics
(66, 21, 3, 'FINAL', 86.00, 100.00, 86.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(67, 22, 3, 'FINAL', 83.00, 100.00, 83.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(68, 23, 3, 'FINAL', 80.00, 100.00, 80.00, 'B', '2024-06-25', NULL, NOW(), NOW()),
(69, 24, 3, 'FINAL', 77.00, 100.00, 77.00, 'C', '2024-06-25', NULL, NOW(), NOW()),
(70, 25, 3, 'FINAL', 74.00, 100.00, 74.00, 'C', '2024-06-25', NULL, NOW(), NOW()),

-- English grades (mostly high scores, few low scores)
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- 18CS-A1 class - English
(71, 11, 4, 'FINAL', 92.00, 100.00, 92.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(72, 12, 4, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(73, 13, 4, 'FINAL', 86.00, 100.00, 86.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(74, 14, 4, 'FINAL', 93.00, 100.00, 93.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(75, 15, 4, 'FINAL', 25.00, 100.00, 25.00, 'F', '2024-06-30', 'Poor English foundation', NOW(), NOW()),

-- 18CS-A2 class - English
(76, 16, 4, 'FINAL', 94.00, 100.00, 94.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(77, 17, 4, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(78, 18, 4, 'FINAL', 88.00, 100.00, 88.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(79, 19, 4, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(80, 20, 4, 'FINAL', 82.00, 100.00, 82.00, 'B', '2024-06-30', NULL, NOW(), NOW()),

-- 18CS-A3 class - English
(81, 21, 4, 'FINAL', 90.00, 100.00, 90.00, 'A', '2024-06-30', NULL, NOW(), NOW()),
(82, 22, 4, 'FINAL', 87.00, 100.00, 87.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(83, 23, 4, 'FINAL', 84.00, 100.00, 84.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(84, 24, 4, 'FINAL', 81.00, 100.00, 81.00, 'B', '2024-06-30', NULL, NOW(), NOW()),
(85, 25, 4, 'FINAL', 32.00, 100.00, 32.00, 'F', '2024-06-30', 'Poor English foundation', NOW(), NOW()),

-- New course grades
INSERT INTO grades (id, student_id, course_id, exam_type, score, total_score, percentage, grade_level, exam_date, remarks, created_at, updated_at) VALUES
-- Operating Systems (19th grade students)
(86, 26, 5, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-10', NULL, NOW(), NOW()),
(87, 27, 5, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-10', NULL, NOW(), NOW()),
(88, 28, 5, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-10', NULL, NOW(), NOW()),
(89, 29, 5, 'FINAL', 87.00, 100.00, 87.00, 'B', '2024-06-10', NULL, NOW(), NOW()),
(90, 30, 5, 'FINAL', 83.00, 100.00, 83.00, 'B', '2024-06-10', NULL, NOW(), NOW()),

-- Computer Networks (20th grade students)
(91, 31, 6, 'FINAL', 93.00, 100.00, 93.00, 'A', '2024-06-12', NULL, NOW(), NOW()),
(92, 32, 6, 'FINAL', 88.00, 100.00, 88.00, 'B', '2024-06-12', NULL, NOW(), NOW()),
(93, 33, 6, 'FINAL', 85.00, 100.00, 85.00, 'B', '2024-06-12', NULL, NOW(), NOW()),
(94, 34, 6, 'FINAL', 82.00, 100.00, 82.00, 'B', '2024-06-12', NULL, NOW(), NOW()),
(95, 35, 6, 'FINAL', 79.00, 100.00, 79.00, 'C', '2024-06-12', NULL, NOW(), NOW()),

-- Database Systems (Software Engineering)
(96, 36, 7, 'FINAL', 95.00, 100.00, 95.00, 'A', '2024-06-18', NULL, NOW(), NOW()),
(97, 37, 7, 'FINAL', 92.00, 100.00, 92.00, 'A', '2024-06-18', NULL, NOW(), NOW()),
(98, 38, 7, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-18', NULL, NOW(), NOW()),
(99, 39, 7, 'FINAL', 86.00, 100.00, 86.00, 'B', '2024-06-18', NULL, NOW(), NOW()),
(100, 40, 7, 'FINAL', 83.00, 100.00, 83.00, 'B', '2024-06-18', NULL, NOW(), NOW()),

-- Linear Algebra (Information Security)
(101, 41, 8, 'FINAL', 78.00, 100.00, 78.00, 'C', '2024-06-22', NULL, NOW(), NOW()),
(102, 42, 8, 'FINAL', 74.00, 100.00, 74.00, 'C', '2024-06-22', NULL, NOW(), NOW()),
(103, 43, 8, 'FINAL', 71.00, 100.00, 71.00, 'C', '2024-06-22', NULL, NOW(), NOW()),
(104, 44, 8, 'FINAL', 68.00, 100.00, 68.00, 'D', '2024-06-22', NULL, NOW(), NOW()),
(105, 45, 8, 'FINAL', 45.00, 100.00, 45.00, 'F', '2024-06-22', 'Weak math foundation', NOW(), NOW()),

-- English Writing (extreme high scores)
(106, 26, 9, 'FINAL', 97.00, 100.00, 97.00, 'A', '2024-06-28', 'Writing genius', NOW(), NOW()),
(107, 27, 9, 'FINAL', 95.00, 100.00, 95.00, 'A', '2024-06-28', NULL, NOW(), NOW()),
(108, 28, 9, 'FINAL', 93.00, 100.00, 93.00, 'A', '2024-06-28', NULL, NOW(), NOW()),
(109, 29, 9, 'FINAL', 91.00, 100.00, 91.00, 'A', '2024-06-28', NULL, NOW(), NOW()),
(110, 30, 9, 'FINAL', 89.00, 100.00, 89.00, 'B', '2024-06-28', NULL, NOW(), NOW()),

-- Advanced Physics (extreme low scores)
(111, 31, 10, 'FINAL', 28.00, 100.00, 28.00, 'F', '2024-07-02', 'Extremely poor physics foundation', NOW(), NOW()),
(112, 32, 10, 'FINAL', 35.00, 100.00, 35.00, 'F', '2024-07-02', 'Needs makeup exam', NOW(), NOW()),
(113, 33, 10, 'FINAL', 42.00, 100.00, 42.00, 'F', '2024-07-02', 'Needs makeup exam', NOW(), NOW()),
(114, 34, 10, 'FINAL', 48.00, 100.00, 48.00, 'F', '2024-07-02', 'Needs makeup exam', NOW(), NOW()),
(115, 35, 10, 'FINAL', 52.00, 100.00, 52.00, 'F', '2024-07-02', 'Needs makeup exam', NOW(), NOW());
