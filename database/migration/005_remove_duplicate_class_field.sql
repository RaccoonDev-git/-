-- 删除重复的class_name字段，保留class字段
-- 因为Student实体类映射的是class字段到className属性

-- 首先确保class字段有数据（如果class_name有数据但class没有）
UPDATE students 
SET class = class_name 
WHERE (class IS NULL OR class = '') AND (class_name IS NOT NULL AND class_name != '');

-- 删除重复的class_name字段
ALTER TABLE students DROP COLUMN class_name;

