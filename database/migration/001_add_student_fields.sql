-- =============================================
-- 学生表字段更新迁移脚本
-- 版本: 2.0
-- 日期: 2025-10-05
-- 说明: 添加缺少的字段以支持增强的学生管理功能
-- =============================================

USE student_analysis_system;

-- 添加 remarks 字段（如果不存在）
ALTER TABLE students 
ADD COLUMN IF NOT EXISTS remarks TEXT COMMENT '备注信息';

-- 添加 enrollment_date 字段（如果不存在）
ALTER TABLE students 
ADD COLUMN IF NOT EXISTS enrollment_date DATE COMMENT '入学日期';

-- 添加 graduation_date 字段（如果不存在）
ALTER TABLE students 
ADD COLUMN IF NOT EXISTS graduation_date DATE COMMENT '毕业日期';

-- 添加 avatar_url 字段（如果不存在）
ALTER TABLE students 
ADD COLUMN IF NOT EXISTS avatar_url VARCHAR(255) COMMENT '头像URL';

-- 确保 class 字段存在（某些版本可能使用 class_name）
-- 注意：如果已有 class_name，需要手动迁移数据
SELECT 
    COLUMN_NAME 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
    TABLE_SCHEMA = 'student_analysis_system' 
    AND TABLE_NAME = 'students' 
    AND COLUMN_NAME IN ('class', 'class_name');

-- 如果需要从 class_name 迁移到 class，取消注释以下代码：
-- ALTER TABLE students CHANGE COLUMN class_name class VARCHAR(100) COMMENT '班级';

-- 验证表结构
DESCRIBE students;

-- 显示完成信息
SELECT 'Migration completed successfully! Students table updated.' AS Status;
