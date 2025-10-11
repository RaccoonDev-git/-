-- Insert minimal test data with correct field names

-- Insert additional courses
INSERT INTO courses (id, code, name, description, teacher_id, credits, semester, academic_year, status, created_at, updated_at) VALUES
(5, 'CS401', 'Operating Systems', 'Operating Systems Course', 2, 4, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(6, 'CS402', 'Computer Networks', 'Computer Networks Course', 2, 3, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(7, 'CS403', 'Database Systems', 'Database Systems Course', 2, 4, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(8, 'MATH201', 'Linear Algebra', 'Linear Algebra Course', 3, 3, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(9, 'ENG101', 'English Writing', 'English Writing Course', 3, 2, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW()),
(10, 'PHYS201', 'Advanced Physics', 'Advanced Physics Course', 3, 4, '2024Spring', '2023-2024', 'ACTIVE', NOW(), NOW());

-- Insert students with correct field names
INSERT INTO students (id, user_id, name, student_number, class_name, grade_level, major, enrollment_date, created_at, updated_at) VALUES
-- 18CS-A1 class
(11, 15, 'John Smith', '20181001', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(12, 16, 'Jane Doe', '20181002', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(13, 17, 'Mike Johnson', '20181003', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(14, 18, 'Sarah Wilson', '20181004', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(15, 19, 'David Brown', '20181005', '18CS-A1', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),

-- 18CS-A2 class
(16, 20, 'Emily Davis', '20181006', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(17, 21, 'Chris Miller', '20181007', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(18, 22, 'Lisa Garcia', '20181008', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(19, 23, 'Tom Rodriguez', '20181009', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(20, 24, 'Anna Martinez', '20181010', '18CS-A2', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),

-- 18CS-A3 class
(21, 25, 'Robert Lee', '20181011', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(22, 26, 'Jennifer White', '20181012', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(23, 27, 'Kevin Taylor', '20181013', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(24, 28, 'Amanda Anderson', '20181014', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),
(25, 29, 'Daniel Thomas', '20181015', '18CS-A3', 2018, 'Computer Science', '2018-09-01', NOW(), NOW()),

-- 19CS-A1 class
(26, 30, 'Rachel Jackson', '20191001', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(27, 31, 'Matthew Moore', '20191002', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(28, 32, 'Jessica Martin', '20191003', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(29, 33, 'Andrew Thompson', '20191004', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),
(30, 34, 'Michelle Garcia', '20191005', '19CS-A1', 2019, 'Computer Science', '2019-09-01', NOW(), NOW()),

-- 20CS-A1 class
(31, 35, 'Ryan Martinez', '20201001', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(32, 36, 'Stephanie Robinson', '20201002', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(33, 37, 'Brandon Clark', '20201003', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(34, 38, 'Nicole Rodriguez', '20201004', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),
(35, 39, 'Tyler Lewis', '20201005', '20CS-A1', 2020, 'Computer Science', '2020-09-01', NOW(), NOW()),

-- Software Engineering class
(36, 40, 'Samantha Lee', '20181016', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(37, 41, 'Justin Walker', '20181017', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(38, 42, 'Megan Hall', '20181018', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(39, 43, 'Nathan Allen', '20181019', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),
(40, 44, 'Lauren Young', '20181020', '18SE-A1', 2018, 'Software Engineering', '2018-09-01', NOW(), NOW()),

-- Information Security class
(41, 45, 'Jonathan King', '20181021', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(42, 46, 'Victoria Wright', '20181022', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(43, 47, 'Alexander Lopez', '20181023', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(44, 48, 'Olivia Hill', '20181024', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW()),
(45, 49, 'William Scott', '20181025', '18IS-A1', 2018, 'Information Security', '2018-09-01', NOW(), NOW());

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
