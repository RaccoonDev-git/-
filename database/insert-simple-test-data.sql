-- Insert simple test data with English names only
-- This avoids character encoding issues

-- Insert additional courses
INSERT INTO courses (id, code, name, description, teacher_id, credits, semester, academic_year, status, created_at, updated_at) VALUES
(5, 'CS401', 'Operating Systems', 'Operating Systems Course', 2, 4, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(6, 'CS402', 'Computer Networks', 'Computer Networks Course', 2, 3, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(7, 'CS403', 'Database Systems', 'Database Systems Course', 2, 4, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(8, 'MATH201', 'Linear Algebra', 'Linear Algebra Course', 3, 3, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(9, 'ENG101', 'English Writing', 'English Writing Course', 3, 2, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(10, 'PHYS201', 'Advanced Physics', 'Advanced Physics Course', 3, 4, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW());

-- Insert students with English names
INSERT INTO students (id, user_id, name, student_number, class_name, grade_level, major, enrollment_date, created_at, updated_at) VALUES
-- 18CS-A1 class
(11, 15, 'student11', 'student11@example.com', '13800138011', '20181001', 'John Smith', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(12, 16, 'student12', 'student12@example.com', '13800138012', '20181002', 'Jane Doe', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(13, 17, 'student13', 'student13@example.com', '13800138013', '20181003', 'Mike Johnson', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(14, 18, 'student14', 'student14@example.com', '13800138014', '20181004', 'Sarah Wilson', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(15, 19, 'student15', 'student15@example.com', '13800138015', '20181005', 'David Brown', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),

-- 18CS-A2 class
(16, 20, 'student16', 'student16@example.com', '13800138016', '20181006', 'Emily Davis', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(17, 21, 'student17', 'student17@example.com', '13800138017', '20181007', 'Chris Miller', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(18, 22, 'student18', 'student18@example.com', '13800138018', '20181008', 'Lisa Garcia', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(19, 23, 'student19', 'student19@example.com', '13800138019', '20181009', 'Tom Rodriguez', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(20, 24, 'student20', 'student20@example.com', '13800138020', '20181010', 'Anna Martinez', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),

-- 18CS-A3 class
(21, 25, 'student21', 'student21@example.com', '13800138021', '20181011', 'Robert Lee', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(22, 26, 'student22', 'student22@example.com', '13800138022', '20181012', 'Jennifer White', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(23, 27, 'student23', 'student23@example.com', '13800138023', '20181013', 'Kevin Taylor', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(24, 28, 'student24', 'student24@example.com', '13800138024', '20181014', 'Amanda Anderson', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(25, 29, 'student25', 'student25@example.com', '13800138025', '20181015', 'Daniel Thomas', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),

-- 19CS-A1 class
(26, 30, 'student26', 'student26@example.com', '13800138026', '20191001', 'Rachel Jackson', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(27, 31, 'student27', 'student27@example.com', '13800138027', '20191002', 'Matthew Moore', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(28, 32, 'student28', 'student28@example.com', '13800138028', '20191003', 'Jessica Martin', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(29, 33, 'student29', 'student29@example.com', '13800138029', '20191004', 'Andrew Thompson', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(30, 34, 'student30', 'student30@example.com', '13800138030', '20191005', 'Michelle Garcia', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),

-- 20CS-A1 class
(31, 35, 'student31', 'student31@example.com', '13800138031', '20201001', 'Ryan Martinez', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(32, 36, 'student32', 'student32@example.com', '13800138032', '20201002', 'Stephanie Robinson', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(33, 37, 'student33', 'student33@example.com', '13800138033', '20201003', 'Brandon Clark', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(34, 38, 'student34', 'student34@example.com', '13800138034', '20201004', 'Nicole Rodriguez', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(35, 39, 'student35', 'student35@example.com', '13800138035', '20201005', 'Tyler Lewis', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),

-- Software Engineering class
(36, 40, 'student36', 'student36@example.com', '13800138036', '20181016', 'Samantha Lee', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(37, 41, 'student37', 'student37@example.com', '13800138037', '20181017', 'Justin Walker', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(38, 42, 'student38', 'student38@example.com', '13800138038', '20181018', 'Megan Hall', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(39, 43, 'student39', 'student39@example.com', '13800138039', '20181019', 'Nathan Allen', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(40, 44, 'student40', 'student40@example.com', '13800138040', '20181020', 'Lauren Young', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),

-- Information Security class
(41, 45, 'student41', 'student41@example.com', '13800138041', '20181021', 'Jonathan King', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(42, 46, 'student42', 'student42@example.com', '13800138042', '20181022', 'Victoria Wright', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(43, 47, 'student43', 'student43@example.com', '13800138043', '20181023', 'Alexander Lopez', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(44, 48, 'student44', 'student44@example.com', '13800138044', '20181024', 'Olivia Hill', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(45, 49, 'student45', 'student45@example.com', '13800138045', '20181025', 'William Scott', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW());

-- Insert corresponding user data
INSERT INTO users (id, username, password, email, role, status, created_at, updated_at) VALUES
(15, 'student11', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student11@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(16, 'student12', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student12@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(17, 'student13', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student13@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(18, 'student14', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student14@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(19, 'student15', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student15@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(20, 'student16', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student16@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(21, 'student17', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student17@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(22, 'student18', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student18@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(23, 'student19', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student19@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(24, 'student20', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student20@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(25, 'student21', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student21@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(26, 'student22', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student22@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(27, 'student23', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student23@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(28, 'student24', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student24@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(29, 'student25', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student25@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(30, 'student26', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student26@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(31, 'student27', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student27@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(32, 'student28', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student28@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(33, 'student29', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student29@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(34, 'student30', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student30@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(35, 'student31', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student31@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(36, 'student32', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student32@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(37, 'student33', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student33@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(38, 'student34', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student34@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(39, 'student35', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student35@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(40, 'student36', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student36@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(41, 'student37', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student37@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(42, 'student38', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student38@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(43, 'student39', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student39@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(44, 'student40', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student40@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(45, 'student41', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student41@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(46, 'student42', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student42@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(47, 'student43', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student43@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(48, 'student44', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student44@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW()),
(49, 'student45', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'student45@example.com', 'STUDENT', 'ACTIVE', NOW(), NOW());
