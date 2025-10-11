# 数据库迁移指南

## 概述

本指南将帮助你在新电脑上完整迁移学生学情分析系统的数据库。

## 迁移文件说明

### 1. 数据库文件

- `database_migration.sql` - 完整的数据库结构和数据导出文件
- `database/schema.sql` - 原始数据库结构文件
- `database/insert-test-data.sql` - 测试数据插入脚本

### 2. 配置文件

- `backend/src/main/resources/application.properties` - 数据库连接配置
- `backend/src/main/resources/application-mysql.properties` - MySQL 特定配置

## 新环境设置步骤

### 步骤 1: 安装必要软件

#### 1.1 安装 Java 17+

```bash
# 下载并安装Java 17或更高版本
# 验证安装
java -version
```

#### 1.2 安装 Maven

```bash
# 下载并安装Maven
# 验证安装
mvn -version
```

#### 1.3 安装 MySQL 8.0+

```bash
# 下载并安装MySQL 8.0或更高版本
# 启动MySQL服务
# 验证安装
mysql --version
```

### 步骤 2: 创建数据库

#### 2.1 登录 MySQL

```bash
mysql -u root -p
```

#### 2.2 创建数据库

```sql
CREATE DATABASE student_analysis CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 2.3 创建用户（可选）

```sql
CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON student_analysis.* TO 'student_user'@'localhost';
FLUSH PRIVILEGES;
```

### 步骤 3: 导入数据库

#### 3.1 导入完整数据库

```bash
mysql -u root -p student_analysis < database_migration.sql
```

#### 3.2 验证导入

```bash
mysql -u root -p -e "USE student_analysis; SHOW TABLES;"
```

### 步骤 4: 配置应用

#### 4.1 更新数据库连接配置

编辑 `backend/src/main/resources/application.properties`:

```properties
# 数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
spring.datasource.username=root
spring.datasource.password=your_mysql_password
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# JPA配置
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
spring.jpa.properties.hibernate.format_sql=true

# Jackson配置 - 解决Hibernate代理序列化问题
spring.jackson.serialization.fail-on-empty-beans=false
spring.jackson.default-property-inclusion=non_null
```

#### 4.2 更新 MySQL 特定配置

编辑 `backend/src/main/resources/application-mysql.properties`:

```properties
# MySQL特定配置
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
spring.datasource.username=root
spring.datasource.password=your_mysql_password
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# JPA配置
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
spring.jpa.properties.hibernate.format_sql=true

# Jackson配置
spring.jackson.serialization.fail-on-empty-beans=false
spring.jackson.default-property-inclusion=non_null
```

### 步骤 5: 启动应用

#### 5.1 编译后端

```bash
cd backend
mvn clean compile
```

#### 5.2 启动后端服务

```bash
mvn spring-boot:run
```

#### 5.3 启动前端服务

```bash
cd frontend
python server.py
```

### 步骤 6: 验证迁移

#### 6.1 测试数据库连接

访问: http://localhost:8080/api/debug/test-db

#### 6.2 测试登录

- 管理员: admin / password123
- 教师: teacher1 / password123
- 学生: student1 / password123

#### 6.3 测试主要功能

- 权重配置管理
- 成绩类型管理
- 学生成绩查询
- 学情分析

## 数据库表结构说明

### 核心表

- `users` - 用户表（管理员、教师、学生）
- `students` - 学生信息表
- `teachers` - 教师信息表
- `courses` - 课程表
- `course_enrollments` - 课程选课表

### 成绩相关表

- `grade_types` - 成绩类型表（平时分类型）
- `grades` - 成绩表
- `comprehensive_grades` - 综合成绩表
- `course_weight_configs` - 课程权重配置表

### 其他表

- `learning_activities` - 学习活动表
- `student_warnings` - 学生预警表
- `messages` - 消息表
- `resources` - 资源表
- `notifications` - 通知表

## 重要配置说明

### 1. 字符编码

数据库使用 `utf8mb4` 编码，支持完整的 Unicode 字符集。

### 2. 时区设置

应用使用 `Asia/Shanghai` 时区。

### 3. 连接池配置

默认使用 HikariCP 连接池，可根据需要调整。

### 4. JPA 配置

- `ddl-auto=validate` - 验证表结构，不自动创建/修改表
- `show-sql=false` - 生产环境不显示 SQL
- `format_sql=true` - 格式化 SQL 输出

## 故障排除

### 1. 连接失败

- 检查 MySQL 服务是否启动
- 验证用户名密码
- 检查防火墙设置

### 2. 字符编码问题

- 确保数据库使用 utf8mb4 编码
- 检查连接字符串中的字符编码设置

### 3. 时区问题

- 确保 MySQL 时区设置正确
- 检查应用时区配置

### 4. 权限问题

- 确保数据库用户有足够权限
- 检查表级权限设置

## 备份建议

### 1. 定期备份

```bash
# 创建备份脚本
mysqldump -u root -p --routines --triggers --single-transaction student_analysis > backup_$(date +%Y%m%d_%H%M%S).sql
```

### 2. 自动化备份

建议设置定时任务自动备份数据库。

## 联系支持

如果遇到问题，请检查：

1. 日志文件：`backend/logs/application.log`
2. 数据库连接状态
3. 应用配置是否正确

---

**注意**: 请确保在新环境中使用相同的 MySQL 版本和配置，以避免兼容性问题。
