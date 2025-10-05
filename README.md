# 学生学习情况分析系统

一个基于 Spring Boot + Flask + MySQL 的全栈学生学习管理与分析系统。

## 📋 项目概述

本系统提供学生、教师、管理员三种角色的完整功能,包括课程管理、成绩管理、学习数据分析等功能。

### 主要功能

- 🔐 **用户认证与授权** - 基于 JWT 的安全认证系统
- 👨‍🎓 **学生管理** - 学生信息管理、课程选课、成绩查询
- 👨‍🏫 **教师管理** - 教师信息管理、课程管理、成绩录入
- 📚 **课程管理** - 课程创建、编辑、删除、查询
- 📊 **成绩管理** - 成绩录入、查询、统计分析
- 📈 **数据分析** - 学习情况可视化分析

## 🏗️ 技术栈

### 后端

- **框架**: Spring Boot 3.2.0
- **语言**: Java 17
- **数据库**: MySQL 8.0
- **安全**: Spring Security + JWT
- **ORM**: Spring Data JPA + Hibernate
- **文档**: SpringDoc OpenAPI (Swagger)
- **工具**: Lombok, MapStruct

### 前端

- **框架**: Flask (Python 3.x)
- **UI**: HTML5 + CSS3 + JavaScript
- **图表**: Chart.js
- **HTTP**: Fetch API

### 数据库

- MySQL 8.0
- 8 个核心表: users, students, teachers, courses, course_enrollments, grades, learning_activities, notifications

## 🚀 快速开始

### 前置要求

- Java 17+
- Maven 3.6+
- MySQL 8.0+
- Python 3.8+
- Git

### 1. 克隆项目

```bash
git clone <repository-url>
cd Student_Learning_Situation_Analysis_System
```

### 2. 数据库设置

#### 启动 MySQL 服务

```bash
# Windows
net start MySQL80

# Linux/Mac
sudo systemctl start mysql
```

#### 创建数据库

```bash
cd database
powershell -ExecutionPolicy Bypass -File create-database.ps1
```

按提示输入 MySQL root 密码,脚本将自动:

- 创建 `student_analysis` 数据库
- 创建所有表结构
- 建立索引和外键关系

#### 插入测试数据

```bash
powershell -ExecutionPolicy Bypass -File insert-test-data.ps1
```

### 3. 后端配置与启动

#### 配置数据库连接

编辑 `backend/src/main/resources/application-mysql.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

#### 编译并启动后端

```bash
cd backend
mvn clean package -DskipTests
java -jar target/student-analysis-system-2.0.0-SNAPSHOT.jar
```

后端将在 `http://localhost:8082` 启动

#### API 文档

访问 Swagger UI: `http://localhost:8082/swagger-ui.html`

### 4. 前端配置与启动

#### 安装 Python 依赖

```bash
cd frontend
pip install -r requirements.txt
```

#### 启动 Flask 服务器

```bash
python server.py
```

或使用快捷脚本:

```bash
# Windows
start-frontend.bat

# PowerShell
.\start-frontend.ps1
```

前端将在 `http://localhost:3000` 启动

### 5. 访问系统

打开浏览器访问: `http://localhost:3000`

## 👥 测试账户

系统预置了以下测试账户(密码统一为 `password123`):

### 管理员

- 用户名: `admin`
- 密码: `password123`
- 邮箱: admin@school.com

### 教师账户

- `teacher1` / `password123` - 张老师
- `teacher2` / `password123` - 李老师
- `teacher3` / `password123` - 王老师

### 学生账户

- `student1` / `password123` - 张三
- `student2` / `password123` - 李四
- `student3` / `password123` - 王五
- `student4` / `password123` - 赵六
- `student5` / `password123` - 孙七

## 📁 项目结构

```
Student_Learning_Situation_Analysis_System/
├── backend/                          # Spring Boot 后端
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/example/studentanalysissystem/
│   │   │   │       ├── config/      # 配置类
│   │   │   │       ├── controller/  # REST API 控制器
│   │   │   │       ├── dto/         # 数据传输对象
│   │   │   │       ├── exception/   # 异常处理
│   │   │   │       ├── mapper/      # MapStruct 映射器
│   │   │   │       ├── model/       # JPA 实体类
│   │   │   │       ├── repository/  # 数据访问层
│   │   │   │       ├── security/    # 安全配置
│   │   │   │       ├── service/     # 业务逻辑层
│   │   │   │       └── util/        # 工具类
│   │   │   └── resources/
│   │   │       ├── application.properties
│   │   │       ├── application-mysql.properties
│   │   │       └── logback-spring.xml
│   │   └── test/                    # 测试代码
│   └── pom.xml                      # Maven 配置
│
├── frontend/                         # Flask 前端
│   ├── src/
│   │   ├── pages/                   # HTML 页面
│   │   │   ├── student/            # 学生页面
│   │   │   ├── teacher/            # 教师页面
│   │   │   └── admin/              # 管理员页面
│   │   ├── assets/
│   │   │   ├── css/                # 样式文件
│   │   │   └── js/                 # JavaScript 文件
│   │   └── components/             # 共享组件
│   ├── server.py                    # Flask 服务器
│   └── requirements.txt             # Python 依赖
│
├── database/                         # 数据库脚本
│   ├── schema.sql                   # 数据库结构
│   ├── insert-test-data.sql        # 测试数据
│   ├── create-database.ps1         # 数据库创建脚本
│   ├── insert-test-data.ps1        # 数据导入脚本
│   └── DATABASE_GUIDE.md           # 数据库文档
│
├── .gitignore                        # Git 忽略文件
└── README.md                         # 项目说明文档
```

## 🔑 核心 API 端点

### 认证相关

- `POST /api/authentication/register` - 用户注册
- `POST /api/authentication/login` - 用户登录
- `POST /api/authentication/change-password` - 修改密码

### 学生管理

- `GET /api/students` - 获取学生列表
- `GET /api/students/{id}` - 获取学生详情
- `POST /api/students` - 创建学生
- `PUT /api/students/{id}` - 更新学生信息
- `DELETE /api/students/{id}` - 删除学生

### 教师管理

- `GET /api/teachers` - 获取教师列表
- `GET /api/teachers/{id}` - 获取教师详情
- `POST /api/teachers` - 创建教师
- `PUT /api/teachers/{id}` - 更新教师信息

### 课程管理

- `GET /api/courses` - 获取课程列表
- `GET /api/courses/{id}` - 获取课程详情
- `POST /api/courses` - 创建课程
- `PUT /api/courses/{id}` - 更新课程信息
- `DELETE /api/courses/{id}` - 删除课程

### 成绩管理

- `GET /api/grades/student/{studentId}` - 获取学生成绩
- `POST /api/grades` - 录入成绩
- `PUT /api/grades/{id}` - 更新成绩

## 🔒 安全性

- ✅ JWT Token 认证
- ✅ BCrypt 密码加密
- ✅ CORS 跨域配置
- ✅ Spring Security 权限控制
- ✅ SQL 注入防护
- ✅ XSS 攻击防护

## 📊 数据库设计

系统包含 8 个核心表:

1. **users** - 用户基础信息表
2. **students** - 学生信息扩展表
3. **teachers** - 教师信息扩展表
4. **courses** - 课程信息表
5. **course_enrollments** - 选课关系表
6. **grades** - 成绩记录表
7. **learning_activities** - 学习活动记录表
8. **notifications** - 通知消息表

详细设计请参考 `database/DATABASE_GUIDE.md`

## 🛠️ 开发指南

### 后端开发

```bash
cd backend
mvn spring-boot:run
```

### 前端开发

```bash
cd frontend
python server.py
```

### 编译打包

```bash
cd backend
mvn clean package
```

## 📝 日志

后端日志位于 `backend/logs/application.log`

## 🤝 贡献

欢迎提交 Issue 和 Pull Request!

## 📄 许可证

本项目仅用于学习和研究目的。

## 📮 联系方式

如有问题或建议,请通过以下方式联系:

- 提交 GitHub Issue
- 发送邮件至项目维护者

---

**开发时间**: 2025 年 10 月
**版本**: 2.0.0-SNAPSHOT
