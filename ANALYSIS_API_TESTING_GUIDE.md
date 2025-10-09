# 数据分析 API 测试指南

## 🚀 快速开始

### 1. 启动后端服务

```powershell
cd backend
mvn spring-boot:run
```

等待启动完成，看到以下信息：

```
Started StudentAnalysisSystemApplication in X.XXX seconds
```

### 2. 访问 Swagger UI

浏览器打开：`http://localhost:8080/swagger-ui.html`

在 Swagger 页面中，找到 **"数据分析"** 标签。

---

## 📊 API 测试步骤

### 前置条件

1. ✅ 后端服务已启动
2. ✅ 数据库中有测试数据
3. ✅ 获取有效的 JWT Token

### 获取 Token

1. **登录接口**:

   ```
   POST /api/authentication/login
   ```

2. **请求体**:

   ```json
   {
     "username": "teacher1",
     "password": "password123"
   }
   ```

3. **复制响应中的 token**

4. **在 Swagger 中认证**:
   - 点击页面右上角的 `Authorize` 按钮
   - 输入：`Bearer {your_token}`
   - 点击 `Authorize`

---

## 🧪 测试用例

### 测试 1: 获取全部成绩统计

**接口**: `GET /api/analysis/grade-statistics`

**参数**: 全部留空

**预期结果**:

```json
{
  "dimension": "overall",
  "dimensionValue": "全部",
  "totalStudents": 60,
  "averageScore": 78.5,
  "maxScore": 98.0,
  "minScore": 42.0,
  "passRate": 85.5,
  "excellentRate": 25.0
}
```

---

### 测试 2: 按课程统计

**接口**: `GET /api/analysis/grade-statistics`

**参数**:

- courseId: 1 (选择一个实际存在的课程 ID)

**预期结果**:

- dimension = "course"
- dimensionValue = 课程名称
- 显示该课程的统计数据

---

### 测试 3: 按班级统计

**接口**: `GET /api/analysis/grade-statistics/class/{className}`

**URL**: `/api/analysis/grade-statistics/class/计算机1班`

**预期结果**:

- dimension = "class"
- dimensionValue = "计算机 1 班"
- 显示该班级的统计数据

---

### 测试 4: 获取学生学习档案

**接口**: `GET /api/analysis/student/{studentId}/profile`

**URL**: `/api/analysis/student/1/profile`

**预期结果**:

```json
{
  "studentId": 1,
  "studentName": "张三",
  "studentNumber": "2024001",
  "className": "计算机1班",
  "summary": {
    "overallAverage": 82.5,
    "classRank": 5,
    "classSize": 45,
    "totalCourses": 8,
    "passedCourses": 7,
    "failedCourses": 1,
    "gpa": 3.2
  },
  "scoreTrend": [
    {
      "semester": "2024-1",
      "average": 80.2,
      "courseCount": 4,
      "passedCount": 4
    }
  ],
  "subjectAnalysis": [
    {
      "courseId": 1,
      "courseName": "数据结构",
      "score": 92.0,
      "classAverage": 78.0,
      "rank": 3,
      "trend": "improving",
      "category": "strong",
      "difference": 14.0
    }
  ],
  "learningActivity": {
    "loginCount": 156,
    "totalStudyTime": 2340,
    "activeLevel": "high",
    "avgStudyTimePerDay": 78,
    "lastLoginDate": "2024-10-05"
  },
  "suggestions": [
    "数据结构表现优秀(92.0分),可以尝试更高难度的题目或参加相关竞赛"
  ]
}
```

---

### 测试 5: 按专业统计

**接口**: `GET /api/analysis/grade-statistics/major/计算机科学与技术`

**预期结果**:

- dimension = "major"
- dimensionValue = "计算机科学与技术"
- 显示该专业的统计数据

---

### 测试 6: 多条件组合查询

**接口**: `GET /api/analysis/grade-statistics`

**参数**:

- className: 计算机 1 班
- semester: 2024-1
- gradeLevel: 2024

**预期结果**:

- 只统计符合所有条件的成绩数据
- dimension 会优先显示第一个非空条件

---

## 🔍 验证要点

### 1. 数据准确性

- ✅ 平均分计算正确
- ✅ 及格率计算正确（及格人数/总人数 \* 100）
- ✅ 分数分布统计正确

### 2. 边界情况

- ✅ 没有成绩数据时返回空统计
- ✅ 单个学生时排名正确
- ✅ 所有学生都及格/都不及格时统计正确

### 3. 性能测试

- ✅ 响应时间 < 2 秒
- ✅ 大数据量时不崩溃

---

## 🐛 常见问题排查

### 问题 1: 401 Unauthorized

**原因**: Token 无效或过期

**解决方案**:

1. 重新登录获取新 token
2. 确保在 Swagger 中正确配置了 `Bearer {token}`

---

### 问题 2: 404 Not Found

**原因**: API 路径错误

**解决方案**:

- 确认 URL：`/api/analysis/...`
- 检查后端是否启动成功

---

### 问题 3: 返回空数据

**原因**:

1. 数据库中没有对应数据
2. 筛选条件过于严格

**解决方案**:

1. 检查数据库中是否有测试数据
2. 运行测试数据插入脚本：`.\database\insert-test-data.ps1`

---

### 问题 4: 500 Internal Server Error

**原因**: 后端代码异常

**解决方案**:

1. 查看后端控制台日志
2. 查看 `backend/logs/application.log`
3. 检查数据库连接是否正常

---

## 📋 测试检查清单

### 基础功能测试

- [ ] 全部成绩统计
- [ ] 按课程统计
- [ ] 按班级统计
- [ ] 按专业统计
- [ ] 学生学习档案

### 高级功能测试

- [ ] 多条件组合查询
- [ ] 不同学期数据对比
- [ ] 成绩趋势分析
- [ ] 学习建议生成

### 权限测试

- [ ] 管理员可以访问所有统计
- [ ] 教师可以访问统计和档案
- [ ] 学生只能访问自己的档案

### 性能测试

- [ ] 响应时间 < 2 秒
- [ ] 100+成绩记录统计
- [ ] 并发 10 个请求

---

## 📊 测试数据准备

### 使用现有测试数据

```powershell
cd database
.\insert-test-data.ps1
```

这会插入：

- 5 个学生
- 3 个教师
- 5 门课程
- 60 条成绩记录

### 验证数据

```sql
-- 查看学生数
SELECT COUNT(*) FROM students;

-- 查看成绩数
SELECT COUNT(*) FROM grades;

-- 查看课程数
SELECT COUNT(*) FROM courses;
```

---

## 🎯 预期测试结果

### 成绩统计

- ✅ 总学生数: 5-60 人
- ✅ 平均分: 60-90 分之间
- ✅ 及格率: 70-95%之间
- ✅ 分数分布合理

### 学生档案

- ✅ 总体概览数据完整
- ✅ 成绩趋势有数据
- ✅ 科目分析列表非空
- ✅ 学习建议至少 1 条

---

## 🔄 测试循环

```
1. 启动服务
   ↓
2. 获取Token
   ↓
3. 访问Swagger
   ↓
4. 测试基础API
   ↓
5. 测试高级功能
   ↓
6. 验证结果
   ↓
7. 记录问题
   ↓
8. 修复问题
   ↓
9. 重新测试
```

---

## 📞 技术支持

如遇问题，请检查：

1. 后端日志：`backend/logs/application.log`
2. 控制台输出
3. Swagger 响应消息
4. 数据库数据

---

**测试状态**: 🟡 待测试  
**文档版本**: v1.0  
**最后更新**: 2025 年 10 月 9 日
