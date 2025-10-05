# 学生管理API文档

## API端点列表

### 基础CRUD操作

#### 1. 创建学生
```
POST /api/students
Content-Type: application/json

{
  "userId": 1,
  "studentNumber": "2024001",
  "name": "张三",
  "className": "计算机1班",
  "gradeLevel": 2024,
  "major": "计算机科学与技术",
  "remarks": "优秀学生"
}

响应: 201 Created
{
  "id": 1,
  "userId": 1,
  "username": "student01",
  "email": "student01@example.com",
  "phone": "13800138000",
  "studentNumber": "2024001",
  "name": "张三",
  "className": "计算机1班",
  "gradeLevel": 2024,
  "major": "计算机科学与技术",
  "enrollmentDate": "2024-09-01",
  "graduationDate": null,
  "avatarUrl": null,
  "remarks": "优秀学生",
  "createdAt": "2024-10-05T10:00:00",
  "updatedAt": "2024-10-05T10:00:00"
}
```

#### 2. 根据ID查询学生
```
GET /api/students/{id}

响应: 200 OK
{
  "id": 1,
  "userId": 1,
  "username": "student01",
  "studentNumber": "2024001",
  "name": "张三",
  ...
}
```

#### 3. 根据学号查询学生
```
GET /api/students/student-number/{studentNumber}

示例: GET /api/students/student-number/2024001

响应: 200 OK
```

#### 4. 查询所有学生
```
GET /api/students

响应: 200 OK
[
  {
    "id": 1,
    "name": "张三",
    ...
  },
  {
    "id": 2,
    "name": "李四",
    ...
  }
]
```

#### 5. 更新学生信息
```
PUT /api/students/{id}
Content-Type: application/json

{
  "name": "张三三",
  "className": "计算机2班",
  "gradeLevel": 2024,
  "major": "软件工程",
  "remarks": "转专业学生",
  "phone": "13800138001"
}

响应: 200 OK
```

#### 6. 删除学生
```
DELETE /api/students/{id}

响应: 204 No Content
```

### 高级查询功能

#### 7. 按班级查询
```
GET /api/students/class/{className}

示例: GET /api/students/class/计算机1班

响应: 200 OK
[
  {
    "id": 1,
    "name": "张三",
    "className": "计算机1班",
    ...
  }
]
```

#### 8. 按年级查询
```
GET /api/students/grade/{gradeLevel}

示例: GET /api/students/grade/2024

响应: 200 OK
```

#### 9. 按专业查询
```
GET /api/students/major/{major}

示例: GET /api/students/major/计算机科学与技术

响应: 200 OK
```

#### 10. 搜索学生
```
GET /api/students/search?keyword={keyword}

示例: GET /api/students/search?keyword=张

说明: 搜索姓名或学号包含关键词的学生

响应: 200 OK
```

### 新增功能（v2.0）

#### 11. 批量删除学生 ⭐
```
DELETE /api/students/batch
Content-Type: application/json

[1, 2, 3, 4, 5]

说明: 传入学生ID数组进行批量删除

响应: 204 No Content
```

#### 12. 高级筛选 ⭐
```
GET /api/students/filter?gradeLevel={gradeLevel}&className={className}&major={major}&keyword={keyword}

示例1: GET /api/students/filter?gradeLevel=2024
示例2: GET /api/students/filter?className=计算机1班&major=计算机科学与技术
示例3: GET /api/students/filter?gradeLevel=2024&keyword=张

说明: 
- 所有参数都是可选的
- 多个参数可以组合使用
- keyword 会搜索姓名和学号

响应: 200 OK
[
  {
    "id": 1,
    "name": "张三",
    ...
  }
]
```

#### 13. 获取学生成绩 ⭐
```
GET /api/students/{id}/grades

响应: 200 OK
[
  {
    "courseId": 1,
    "courseName": "数据结构",
    "score": 92,
    "credit": 4,
    "semester": "2024-2025-1"
  }
]
```

#### 14. 获取学生选课情况 ⭐
```
GET /api/students/{id}/courses

响应: 200 OK
[
  {
    "courseId": 1,
    "courseName": "数据结构",
    "teacherName": "王老师",
    "status": "ENROLLED",
    "enrollmentDate": "2024-09-01"
  }
]
```

## 错误响应

### 400 Bad Request
```json
{
  "timestamp": "2024-10-05T10:00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "请求参数错误",
  "path": "/api/students"
}
```

### 404 Not Found
```json
{
  "timestamp": "2024-10-05T10:00:00",
  "status": 404,
  "error": "Not Found",
  "message": "Student not found with id: 999",
  "path": "/api/students/999"
}
```

### 409 Conflict
```json
{
  "timestamp": "2024-10-05T10:00:00",
  "status": 409,
  "error": "Conflict",
  "message": "Student already exists with studentNumber: 2024001",
  "path": "/api/students"
}
```

## 前端集成示例

### 1. 获取所有学生（带筛选）
```javascript
async function loadStudents(filters) {
  const params = new URLSearchParams();
  if (filters.gradeLevel) params.append('gradeLevel', filters.gradeLevel);
  if (filters.className) params.append('className', filters.className);
  if (filters.major) params.append('major', filters.major);
  if (filters.keyword) params.append('keyword', filters.keyword);
  
  const response = await fetch(`/api/students/filter?${params}`, {
    headers: {
      'Authorization': `Bearer ${token}`
    }
  });
  
  return await response.json();
}
```

### 2. 批量删除学生
```javascript
async function batchDeleteStudents(studentIds) {
  const response = await fetch('/api/students/batch', {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify(studentIds)
  });
  
  if (response.ok) {
    alert('删除成功');
  }
}
```

### 3. 更新学生信息
```javascript
async function updateStudent(studentId, data) {
  const response = await fetch(`/api/students/${studentId}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify(data)
  });
  
  return await response.json();
}
```

### 4. 搜索学生
```javascript
async function searchStudents(keyword) {
  const response = await fetch(`/api/students/search?keyword=${encodeURIComponent(keyword)}`, {
    headers: {
      'Authorization': `Bearer ${token}`
    }
  });
  
  return await response.json();
}
```

## 数据字段说明

### Student 对象字段

| 字段名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | Long | 自动生成 | 学生ID |
| userId | Long | 是 | 关联用户ID |
| username | String | 只读 | 用户名 |
| email | String | 否 | 邮箱（来自用户表）|
| phone | String | 否 | 手机号（来自用户表）|
| studentNumber | String | 是 | 学号（唯一）|
| name | String | 是 | 姓名 |
| className | String | 否 | 班级 |
| gradeLevel | Integer | 否 | 年级 |
| major | String | 否 | 专业 |
| enrollmentDate | Date | 否 | 入学日期 |
| graduationDate | Date | 否 | 毕业日期 |
| avatarUrl | String | 否 | 头像URL |
| remarks | String | 否 | 备注信息 |
| createdAt | DateTime | 自动生成 | 创建时间 |
| updatedAt | DateTime | 自动更新 | 更新时间 |

## API版本变更记录

### v2.0 (2024-10-05)
- ✅ 添加批量删除接口 `/api/students/batch`
- ✅ 添加高级筛选接口 `/api/students/filter`
- ✅ 添加获取学生成绩接口 `/api/students/{id}/grades`
- ✅ 添加获取学生选课接口 `/api/students/{id}/courses`
- ✅ StudentResponse增加字段: email, phone, enrollmentDate, graduationDate, avatarUrl
- ✅ UpdateStudentRequest增加字段: name, enrollmentDate, graduationDate, remarks, phone
- ✅ 数据库表添加字段: remarks, enrollment_date, graduation_date, avatar_url

### v1.0 (2024-10-04)
- 基础CRUD操作
- 按班级/年级/专业查询
- 简单搜索功能

## 测试用例

### 测试批量删除
```bash
curl -X DELETE http://localhost:8080/api/students/batch \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '[1, 2, 3]'
```

### 测试高级筛选
```bash
curl -X GET "http://localhost:8080/api/students/filter?gradeLevel=2024&className=计算机1班" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 测试更新学生
```bash
curl -X PUT http://localhost:8080/api/students/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "name": "张三三",
    "className": "计算机2班",
    "remarks": "更新测试"
  }'
```

---

**版本**: v2.0  
**更新日期**: 2024年10月5日  
**维护团队**: Student Learning Analysis System
