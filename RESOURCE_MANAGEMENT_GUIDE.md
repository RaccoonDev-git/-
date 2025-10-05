# 教学资源管理功能使用指南

## 功能概述

教学资源管理系统提供了完整的教学资源上传、下载、搜索、过滤和删除功能,支持多种文件类型,适用于教师和管理员。

## 功能特性

### ✨ 核心功能

1. **文件上传**

   - 支持多文件批量上传
   - 最大文件大小: 50MB
   - 支持的文件类型:
     - 文档: PDF, DOC, DOCX, TXT
     - 演示文稿: PPT, PPTX
     - 表格: XLS, XLSX
     - 图片: JPG, JPEG, PNG, GIF, BMP
     - 视频: MP4, AVI, MOV, WMV, FLV
     - 音频: MP3, WAV, AAC
     - 压缩包: ZIP, RAR, 7Z
   - 自动文件类型识别

2. **文件下载**

   - 一键下载资源文件
   - 自动记录下载次数
   - 支持原始文件名下载

3. **搜索功能**

   - 实时搜索资源名称
   - 搜索资源描述内容
   - 支持模糊匹配

4. **过滤功能**

   - 按文件类型过滤 (PDF, PPT, DOC, Excel, Image, Video, Audio, Archive)
   - 按上传者过滤
   - 按课程过滤
   - 按分类过滤
   - 支持多条件组合过滤

5. **资源管理**
   - 查看资源详情 (文件大小、上传时间、下载次数)
   - 删除资源 (软删除,支持恢复)
   - 查看我上传的资源

### 🔐 权限控制

- **管理员 (ADMIN)**:

  - ✅ 上传资源
  - ✅ 下载资源
  - ✅ 删除任何资源
  - ✅ 查看所有资源

- **教师 (TEACHER)**:

  - ✅ 上传资源
  - ✅ 下载资源
  - ✅ 删除自己上传的资源
  - ✅ 查看所有资源

- **学生 (STUDENT)**:
  - ❌ 不能上传资源
  - ✅ 下载资源
  - ❌ 不能删除资源
  - ✅ 查看所有资源

## 技术架构

### 后端技术栈

- **框架**: Spring Boot 3.2.0
- **持久化**: Spring Data JPA + Hibernate
- **数据库**: MySQL 8.0
- **文件存储**: 本地文件系统
- **安全**: Spring Security + JWT

### 数据库表结构

```sql
CREATE TABLE resources (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,                    -- 资源名称
    original_filename VARCHAR(255) NOT NULL,       -- 原始文件名
    file_type VARCHAR(50) NOT NULL,                -- 文件类型
    file_path VARCHAR(500) NOT NULL,               -- 文件存储路径
    file_size BIGINT,                              -- 文件大小(字节)
    description TEXT,                               -- 资源描述
    uploader_id BIGINT NOT NULL,                   -- 上传者ID
    uploader_name VARCHAR(100),                    -- 上传者姓名
    course_id BIGINT,                              -- 关联课程ID
    category VARCHAR(50),                          -- 资源分类
    download_count INT DEFAULT 0,                  -- 下载次数
    upload_time DATETIME NOT NULL,                 -- 上传时间
    update_time DATETIME,                          -- 更新时间
    is_active TINYINT(1) DEFAULT 1,               -- 是否有效(软删除)
    INDEX idx_file_type (file_type),
    INDEX idx_uploader_id (uploader_id),
    INDEX idx_course_id (course_id),
    INDEX idx_category (category),
    INDEX idx_upload_time (upload_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### API 接口

#### 1. 上传资源

```http
POST /api/resources
Authorization: Bearer {token}
Content-Type: multipart/form-data

参数:
- file: 文件 (required)
- name: 资源名称 (optional)
- description: 资源描述 (optional)
- uploaderId: 上传者ID (required)
- uploaderName: 上传者姓名 (optional)
- courseId: 课程ID (optional)
- category: 分类 (optional)

返回: ResourceResponse
```

#### 2. 下载资源

```http
GET /api/resources/{id}/download
Authorization: Bearer {token}

返回: 文件流
```

#### 3. 获取资源详情

```http
GET /api/resources/{id}
Authorization: Bearer {token}

返回: ResourceResponse
```

#### 4. 获取所有资源列表

```http
GET /api/resources
Authorization: Bearer {token}

返回: List<ResourceResponse>
```

#### 5. 按文件类型过滤

```http
GET /api/resources/type/{fileType}
Authorization: Bearer {token}

参数: fileType (pdf, doc, ppt, excel, image, video, audio, archive, other)

返回: List<ResourceResponse>
```

#### 6. 获取我上传的资源

```http
GET /api/resources/my?uploaderId={uploaderId}
Authorization: Bearer {token}

返回: List<ResourceResponse>
```

#### 7. 搜索资源

```http
GET /api/resources/search?keyword={keyword}
Authorization: Bearer {token}

返回: List<ResourceResponse>
```

#### 8. 多条件过滤

```http
GET /api/resources/filter?fileType={type}&category={category}&uploaderId={id}
Authorization: Bearer {token}

返回: List<ResourceResponse>
```

#### 9. 删除资源

```http
DELETE /api/resources/{id}?userId={userId}
Authorization: Bearer {token}

返回: 200 OK 或 403 Forbidden
```

### 响应数据格式

```json
{
  "id": 1,
  "name": "C语言程序设计",
  "originalFilename": "c_programming.pdf",
  "fileType": "pdf",
  "fileSize": 2048576,
  "description": "C语言基础教程",
  "uploaderId": 1,
  "uploaderName": "张老师",
  "courseId": 1,
  "category": "课件",
  "downloadCount": 15,
  "uploadTime": "2024-01-20T10:30:00",
  "updateTime": null
}
```

## 前端集成

### JavaScript API 调用示例

#### 加载资源列表

```javascript
async function loadResources() {
  const token = localStorage.getItem("token");
  const response = await fetch(`${API_BASE_URL}/resources`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });
  resources = await response.json();
  displayResources();
}
```

#### 上传文件

```javascript
async function handleFileUpload(event) {
  const files = event.target.files;
  const userId = getCurrentUserId();
  const token = localStorage.getItem("token");

  for (let file of files) {
    const formData = new FormData();
    formData.append("file", file);
    formData.append("name", file.name);
    formData.append("uploaderId", userId);
    formData.append("category", "课件");

    const response = await fetch(`${API_BASE_URL}/resources`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${token}`,
      },
      body: formData,
    });

    if (response.ok) {
      showNotification(`文件 ${file.name} 上传成功!`, "success");
    }
  }

  await loadResources();
}
```

#### 下载文件

```javascript
async function downloadResource(id) {
  const token = localStorage.getItem("token");
  const response = await fetch(`${API_BASE_URL}/resources/${id}/download`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });

  const blob = await response.blob();
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  a.click();
}
```

#### 删除资源

```javascript
async function deleteResource(id) {
  if (!confirm("确定要删除这个资源吗?")) return;

  const userId = getCurrentUserId();
  const token = localStorage.getItem("token");

  const response = await fetch(
    `${API_BASE_URL}/resources/${id}?userId=${userId}`,
    {
      method: "DELETE",
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );

  if (response.ok) {
    showNotification("资源删除成功!", "success");
    await loadResources();
  }
}
```

## 部署和配置

### 1. 配置文件存储目录

在 `application.properties` 中配置:

```properties
# 文件上传配置
spring.servlet.multipart.enabled=true
spring.servlet.multipart.max-file-size=50MB
spring.servlet.multipart.max-request-size=50MB
file.upload-dir=uploads
```

### 2. 创建上传目录

后端会自动创建上传目录,但也可以手动创建:

```bash
mkdir uploads
```

### 3. 数据库迁移

执行数据库迁移脚本:

```bash
mysql -u root -p student_analysis < database/migration/003_create_resources_table.sql
```

### 4. 启动后端服务

```bash
cd backend
mvn spring-boot:run
```

### 5. 启动前端服务

```bash
cd frontend
python server.py
# 或
./start-frontend.bat
```

## 测试流程

### 1. 测试上传功能

1. 使用教师账号登录
2. 进入"教学资源"标签页
3. 点击"上传资源"按钮
4. 选择文件并上传
5. 检查是否出现在资源列表中

### 2. 测试下载功能

1. 在资源列表中点击"下载"按钮
2. 检查文件是否正确下载
3. 验证下载次数是否增加

### 3. 测试搜索功能

1. 在搜索框输入关键词
2. 验证搜索结果是否正确

### 4. 测试过滤功能

1. 选择文件类型过滤器
2. 验证只显示对应类型的文件

### 5. 测试删除功能

1. 点击资源的"删除"按钮
2. 确认删除
3. 验证资源是否从列表中移除

### 6. 测试权限控制

1. 使用学生账号登录
2. 验证无法看到"上传"按钮
3. 验证无法看到"删除"按钮
4. 验证可以下载资源

## 故障排除

### 问题 1: 文件上传失败

**可能原因**:

- 文件大小超过限制
- 上传目录权限不足
- 磁盘空间不足

**解决方法**:

```bash
# 检查上传目录权限
ls -la uploads/

# 增加文件大小限制
# 在 application.properties 中修改:
spring.servlet.multipart.max-file-size=100MB
spring.servlet.multipart.max-request-size=100MB
```

### 问题 2: 下载文件失败

**可能原因**:

- 文件已被删除
- 文件路径错误
- 权限不足

**解决方法**:

```bash
# 检查文件是否存在
ls -la uploads/

# 检查数据库中的文件路径
SELECT id, file_path, original_filename FROM resources WHERE id = {id};
```

### 问题 3: 403 权限错误

**可能原因**:

- Token 过期
- 用户角色不足
- SecurityConfig 配置错误

**解决方法**:

1. 重新登录获取新 token
2. 检查用户角色
3. 验证 SecurityConfig.java 中的配置:

```java
.requestMatchers("/api/resources/**").hasAnyRole("ADMIN", "TEACHER", "STUDENT")
```

### 问题 4: 资源列表为空

**可能原因**:

- API 调用失败
- 数据库连接失败
- 权限问题

**解决方法**:

```bash
# 检查后端日志
tail -f backend/logs/application.log

# 检查数据库连接
mysql -u root -p student_analysis
SELECT COUNT(*) FROM resources WHERE is_active = 1;
```

## 最佳实践

### 1. 文件命名规范

- 使用有意义的文件名
- 添加课程信息前缀
- 示例: `[数据结构]_第一章_线性表.pdf`

### 2. 资源分类建议

- 课件 (PPT, PDF)
- 教材 (PDF, DOC)
- 作业 (DOC, PDF)
- 视频 (MP4)
- 代码 (ZIP)
- 其他

### 3. 描述信息填写

- 简要说明资源内容
- 标注适用课程和章节
- 注明使用注意事项

### 4. 定期维护

- 定期清理过期资源
- 备份重要资源
- 检查磁盘空间使用情况

## 扩展功能建议

### 短期优化 (1-2 周)

- [ ] 添加文件预览功能 (PDF, 图片)
- [ ] 添加文件上传进度条
- [ ] 添加批量删除功能
- [ ] 添加资源收藏功能
- [ ] 优化搜索算法 (全文搜索)

### 中期优化 (1-2 个月)

- [ ] 实现资源评分和评论
- [ ] 添加资源标签系统
- [ ] 实现资源分享功能
- [ ] 添加资源访问统计
- [ ] 支持在线编辑 (Office 365 集成)

### 长期优化 (3-6 个月)

- [ ] 接入云存储 (OSS, S3)
- [ ] 实现 CDN 加速
- [ ] 添加视频转码功能
- [ ] 实现智能推荐系统
- [ ] 支持移动端 APP

## 维护和监控

### 监控指标

- 上传成功率
- 下载成功率
- 平均响应时间
- 存储空间使用率
- 错误日志统计

### 日志查看

```bash
# 查看应用日志
tail -f backend/logs/application.log

# 查看错误日志
grep ERROR backend/logs/application.log

# 查看文件上传日志
grep "uploadResource" backend/logs/application.log
```

### 数据备份

```bash
# 备份数据库
mysqldump -u root -p student_analysis resources > resources_backup.sql

# 备份文件
tar -czf uploads_backup.tar.gz uploads/
```

## 联系支持

如有问题,请联系开发团队或查看项目文档:

- GitHub: [项目地址]
- 文档: README.md, API_DOCUMENTATION.md
- 日志: backend/logs/application.log

---

**最后更新**: 2024-01-20
**版本**: 1.0.0
**维护者**: 开发团队
