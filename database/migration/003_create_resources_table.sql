-- 创建教学资源表
CREATE TABLE IF NOT EXISTS resources (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL COMMENT '资源名称',
    original_filename VARCHAR(255) NOT NULL COMMENT '原始文件名',
    file_type VARCHAR(50) NOT NULL COMMENT '文件类型(pdf, doc, ppt, video等)',
    file_path VARCHAR(500) NOT NULL COMMENT '文件存储路径',
    file_size BIGINT COMMENT '文件大小(字节)',
    description TEXT COMMENT '资源描述',
    uploader_id BIGINT NOT NULL COMMENT '上传者ID',
    uploader_name VARCHAR(100) COMMENT '上传者姓名',
    course_id BIGINT COMMENT '关联课程ID',
    category VARCHAR(50) COMMENT '资源分类(课件、作业、试卷、素材等)',
    download_count INT DEFAULT 0 COMMENT '下载次数',
    upload_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
    update_time DATETIME COMMENT '更新时间',
    is_active TINYINT(1) DEFAULT 1 COMMENT '是否有效',
    INDEX idx_file_type (file_type),
    INDEX idx_uploader (uploader_id),
    INDEX idx_course (course_id),
    INDEX idx_category (category),
    INDEX idx_upload_time (upload_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='教学资源表';
