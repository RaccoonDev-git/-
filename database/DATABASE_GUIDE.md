# 数据库设置指南

## 📊 数据库信息

- **数据库名称**: `student_analysis`
- **数据库类型**: MySQL 8.0+
- **字符集**: utf8mb4
- **排序规则**: utf8mb4_unicode_ci
- **主机地址**: localhost
- **端口号**: 3306
- **用户名**: root

---

## 🚀 快速开始

### 方法 1: 使用自动化脚本 (推荐)

#### 1. 创建数据库

```powershell
cd database
.\create-database.ps1
```

#### 2. 插入测试数据

```powershell
.\insert-test-data.ps1
```

### 方法 2: 手动执行 SQL

#### 1. 创建数据库

```bash
mysql -u root -p -e "CREATE DATABASE student_analysis CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```

#### 2. 执行架构脚本

```bash
mysql -u root -p student_analysis < schema.sql
```

#### 3. 插入测试数据

```bash
mysql -u root -p student_analysis < insert-test-data.sql
```

---

## 📋 数据表结构

系统包含 8 个核心数据表:

| 表名                    | 说明         | 主要字段                                                     |
| ----------------------- | ------------ | ------------------------------------------------------------ |
| **users**               | 用户基础信息 | id, username, password, role, email, phone, status           |
| **students**            | 学生详细信息 | id, user_id, name, student_number, class, grade_level, major |
| **teachers**            | 教师详细信息 | id, user_id, name, employee_number, department, title        |
| **courses**             | 课程信息     | id, name, code, teacher_id, credits, hours, semester         |
| **course_enrollments**  | 选课记录     | id, student_id, course_id, status                            |
| **grades**              | 成绩信息     | id, student_id, course_id, exam_type, score, grade_level     |
| **learning_activities** | 学习活动记录 | id, student_id, course_id, activity_type, duration           |
| **notifications**       | 系统通知     | id, user_id, title, content, type, is_read                   |

### 表关系图

```
users (用户表)
  ├── students (1:1) - 学生信息
  ├── teachers (1:1) - 教师信息
  └── notifications (1:N) - 用户通知

teachers (教师表)
  └── courses (1:N) - 授课课程

students (学生表)
  ├── course_enrollments (1:N) - 选课记录
  ├── grades (1:N) - 成绩记录
  └── learning_activities (1:N) - 学习活动

courses (课程表)
  ├── course_enrollments (1:N) - 选课学生
  ├── grades (1:N) - 课程成绩
  └── learning_activities (1:N) - 学习活动
```

---

## 👥 测试账号

### 管理员

- **用户名**: `admin`
- **密码**: `password123`
- **邮箱**: admin@school.com

### 教师

| 用户名   | 密码        | 姓名   | 工号 | 部门       |
| -------- | ----------- | ------ | ---- | ---------- |
| teacher1 | password123 | 张老师 | T001 | 计算机学院 |
| teacher2 | password123 | 李老师 | T002 | 计算机学院 |
| teacher3 | password123 | 王老师 | T003 | 数学学院   |

### 学生

| 用户名   | 密码        | 姓名   | 学号    | 班级        | 年级 |
| -------- | ----------- | ------ | ------- | ----------- | ---- |
| student1 | password123 | 陈同学 | 2021001 | 计算机 2101 | 3    |
| student2 | password123 | 刘同学 | 2021002 | 计算机 2101 | 3    |
| student3 | password123 | 赵同学 | 2022001 | 计算机 2201 | 2    |
| student4 | password123 | 孙同学 | 2022002 | 软件 2201   | 2    |
| student5 | password123 | 周同学 | 2023001 | 计算机 2301 | 1    |

---

## 📚 测试数据统计

插入的测试数据包括:

- ✅ **9 个用户** (1 管理员 + 3 教师 + 5 学生)
- ✅ **3 位教师** 详细信息
- ✅ **5 位学生** 详细信息
- ✅ **5 门课程** (数据结构、数据库系统、高等数学、算法分析、操作系统)
- ✅ **14 条选课记录**
- ✅ **15 条成绩记录** (涵盖期中、期末、作业等多种考试类型)
- ✅ **9 条学习活动记录** (登录、查看资料、提交作业、测验等)
- ✅ **5 条通知信息**

### 课程信息

| 课程名称   | 课程编号 | 授课教师 | 学分 | 课时 |
| ---------- | -------- | -------- | ---- | ---- |
| 数据结构   | CS101    | 张老师   | 4.0  | 64   |
| 数据库系统 | CS201    | 李老师   | 3.5  | 56   |
| 高等数学   | MATH101  | 王老师   | 5.0  | 80   |
| 算法分析   | CS301    | 张老师   | 4.0  | 64   |
| 操作系统   | CS202    | 李老师   | 4.0  | 64   |

---

## ⚙️ 后端配置

### 配置文件位置

```
backend/src/main/resources/application-mysql.properties
```

### 数据库连接配置

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=你的密码
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
```

**⚠️ 重要**: 请确保 `spring.datasource.password` 配置与你的 MySQL 密码一致!

---

## 🔍 常用 SQL 查询

### 查看所有用户

```sql
SELECT u.id, u.username, u.role, u.email, u.status
FROM users u
ORDER BY u.role, u.id;
```

### 查看学生选课情况

```sql
SELECT s.name AS student_name, c.name AS course_name, ce.status, ce.enrollment_date
FROM course_enrollments ce
JOIN students s ON ce.student_id = s.id
JOIN courses c ON ce.course_id = c.id
ORDER BY s.name, c.name;
```

### 查看学生成绩

```sql
SELECT s.name AS student_name, c.name AS course_name,
       g.exam_type, g.score, g.grade_level, g.exam_date
FROM grades g
JOIN students s ON g.student_id = s.id
JOIN courses c ON g.course_id = c.id
ORDER BY s.name, c.name, g.exam_date;
```

### 查看教师授课情况

```sql
SELECT t.name AS teacher_name, c.name AS course_name,
       c.semester, c.credits, c.hours
FROM courses c
JOIN teachers t ON c.teacher_id = t.id
ORDER BY t.name, c.name;
```

### 查看学生平均成绩

```sql
SELECT s.name AS student_name, c.name AS course_name,
       AVG(g.score) AS avg_score,
       COUNT(g.id) AS exam_count
FROM grades g
JOIN students s ON g.student_id = s.id
JOIN courses c ON g.course_id = c.id
GROUP BY s.id, c.id
ORDER BY avg_score DESC;
```

---

## 🛠️ 数据库维护

### 重置数据库 (慎用!)

```powershell
cd database
.\create-database.ps1  # 会删除并重新创建数据库
.\insert-test-data.ps1 # 重新插入测试数据
```

### 清空所有数据

```sql
USE student_analysis;
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
```

### 备份数据库

```bash
mysqldump -u root -p student_analysis > backup_$(date +%Y%m%d).sql
```

### 恢复数据库

```bash
mysql -u root -p student_analysis < backup_20241005.sql
```

---

## 📊 数据库性能优化

### 已创建的索引

所有表都已经创建了适当的索引以优化查询性能:

- **users**: username, email, phone, role, status
- **students**: student_number, class, grade_level, name
- **teachers**: employee_number, department, name
- **courses**: code, teacher_id, semester, status, name
- **course_enrollments**: student_id, course_id, status, (student_id + course_id) 唯一索引
- **grades**: student_id, course_id, exam_date, exam_type, (student_id + course_id) 组合索引
- **learning_activities**: student_id, course_id, activity_type, created_at
- **notifications**: user_id, is_read, type, created_at

---

## ❓ 常见问题

### 1. 连接数据库失败

**错误**: `Access denied for user 'root'@'localhost'`

**解决方法**:

- 检查 MySQL 密码是否正确
- 确认 MySQL 服务是否运行: `Get-Service MySQL*`
- 检查 `application-mysql.properties` 中的密码配置

### 2. 字符编码问题

**错误**: `Incorrect string value`

**解决方法**:

- 确保数据库使用 utf8mb4 字符集
- 在 SQL 文件开头添加: `SET NAMES utf8mb4;`
- 检查 JDBC URL 包含: `characterEncoding=utf8`

### 3. 外键约束错误

**错误**: `Cannot add or update a child row: a foreign key constraint fails`

**解决方法**:

- 按正确顺序插入数据 (先插入父表,再插入子表)
- 临时禁用外键检查: `SET FOREIGN_KEY_CHECKS = 0;`

### 4. 表已存在

**错误**: `Table 'xxx' already exists`

**解决方法**:

- 所有 CREATE TABLE 语句都使用了 `IF NOT EXISTS`
- 如需重建: 先删除数据库 `DROP DATABASE student_analysis;`

---

## 🎯 下一步

数据库创建完成后:

1. **启动后端服务**

   ```bash
   cd backend
   mvn spring-boot:run
   ```

2. **启动前端服务**

   ```bash
   cd frontend
   python server.py
   ```

3. **访问系统**

   - 前端: http://localhost:3000
   - 后端 API: http://localhost:8082
   - Swagger 文档: http://localhost:8082/swagger-ui.html

4. **测试登录**
   - 使用上述测试账号登录系统
   - 验证各项功能是否正常

---

## 📝 数据库版本

- **版本**: 2.0
- **创建日期**: 2025-10-04
- **最后更新**: 2025-10-05
- **兼容 Spring Boot**: 3.2.0
- **兼容 MySQL**: 8.0+

---

**提示**: 生产环境部署前,请务必修改默认密码并配置适当的访问权限!
