# 🚀 快速启动指南

## 前置条件

### 环境要求
- ✅ Java 17+
- ✅ MySQL 8.0+
- ✅ Python 3.8+（用于前端服务器）
- ✅ Maven 3.6+

### 必需工具
- Git
- IDE（推荐IntelliJ IDEA或VS Code）
- 数据库客户端（推荐MySQL Workbench）

---

## 🗄️ 数据库设置

### 1. 创建数据库
```bash
cd database
# Windows PowerShell
.\create-database.ps1

# 或手动执行
mysql -u root -p < schema.sql
```

### 2. 运行迁移脚本（重要！⚠️）
```bash
# 运行新字段迁移脚本
mysql -u root -p student_analysis_system < migration/001_add_student_fields.sql
```

### 3. 插入测试数据（可选）
```bash
# Windows PowerShell
.\insert-test-data.ps1

# 或手动执行
mysql -u root -p student_analysis_system < insert-test-data.sql
```

### 4. 验证数据库
```sql
USE student_analysis_system;

-- 检查表结构
DESCRIBE students;

-- 应该看到以下新字段:
-- remarks, enrollment_date, graduation_date, avatar_url
```

---

## 🔧 后端设置

### 1. 配置数据库连接
编辑 `backend/src/main/resources/application.properties`:
```properties
# 数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis_system
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD

# 确保使用MySQL配置
spring.profiles.active=mysql
```

### 2. 构建项目
```bash
cd backend
mvn clean install
```

### 3. 启动后端服务
```bash
mvn spring-boot:run
```

### 4. 验证后端
访问: http://localhost:8080/swagger-ui/index.html

检查API文档，确保以下新端点存在：
- ✅ DELETE /api/students/batch
- ✅ GET /api/students/filter
- ✅ GET /api/students/{id}/grades
- ✅ GET /api/students/{id}/courses

---

## 🎨 前端设置

### 1. 安装依赖（如果需要）
```bash
cd frontend
pip install -r requirements.txt
```

### 2. 启动前端服务器

#### Windows PowerShell
```powershell
.\start-frontend.ps1
```

#### 手动启动
```bash
python server.py
```

### 3. 访问应用
浏览器打开: http://localhost:3000

---

## 👤 登录测试

### 教师账号（默认）
- **用户名**: teacher01
- **密码**: teacher123

### 学生账号（默认）
- **用户名**: student01
- **密码**: student123

---

## ✅ 功能验证清单

### 学生管理功能测试

#### 1. 基础功能
- [ ] 登录系统（教师账号）
- [ ] 进入仪表板
- [ ] 切换到"学生管理"模块

#### 2. 视图功能
- [ ] 点击"表格视图"按钮
- [ ] 点击"卡片视图"按钮
- [ ] 验证视图切换正常

#### 3. 筛选功能
- [ ] 选择年级筛选
- [ ] 选择班级筛选
- [ ] 选择专业筛选
- [ ] 组合筛选测试

#### 4. 搜索功能
- [ ] 输入学生姓名搜索
- [ ] 输入学号搜索
- [ ] 点击清空按钮

#### 5. 排序功能
- [ ] 点击"姓名"列排序
- [ ] 点击"学号"列排序
- [ ] 点击"班级"列排序
- [ ] 验证升序/降序切换

#### 6. 分页功能
- [ ] 点击"首页"按钮
- [ ] 点击"上一页"按钮
- [ ] 点击"下一页"按钮
- [ ] 点击"末页"按钮
- [ ] 输入页码跳转
- [ ] 更改每页显示数量

#### 7. 批量操作
- [ ] 点击"批量操作"按钮
- [ ] 勾选多个学生
- [ ] 点击"全选"
- [ ] 点击"批量删除"（取消确认）
- [ ] 点击"批量导出"

#### 8. 学生详情
- [ ] 点击"查看"按钮
- [ ] 切换各个标签页
- [ ] 点击"编辑"按钮
- [ ] 修改学生信息
- [ ] 点击"保存"

#### 9. 导入功能
- [ ] 点击"导入"按钮
- [ ] 下载模板
- [ ] 上传CSV文件
- [ ] 预览数据
- [ ] 确认导入

#### 10. 导出功能
- [ ] 点击"导出"按钮
- [ ] 验证CSV文件下载
- [ ] 用Excel打开验证

#### 11. 主题切换
- [ ] 切换到日间模式
- [ ] 切换到夜间模式
- [ ] 验证所有新组件样式正常

---

## 🔍 故障排查

### 问题1: 数据库连接失败
**症状**: 后端启动报错 "Could not connect to database"

**解决**:
1. 检查MySQL服务是否运行
2. 验证数据库用户名和密码
3. 确认数据库已创建: `student_analysis_system`
4. 检查端口是否被占用（默认3306）

### 问题2: 新字段不存在
**症状**: API返回错误 "Unknown column 'remarks'"

**解决**:
```bash
# 运行迁移脚本
cd database
mysql -u root -p student_analysis_system < migration/001_add_student_fields.sql

# 验证字段
mysql -u root -p -e "DESCRIBE student_analysis_system.students;"
```

### 问题3: 前端无法访问后端API
**症状**: 浏览器控制台显示 "CORS error" 或 "404 Not Found"

**解决**:
1. 确认后端服务正在运行（8080端口）
2. 检查WebConfig中的CORS配置
3. 验证API路径正确: `/api/students/*`

### 问题4: 批量删除不工作
**症状**: 点击批量删除无反应

**解决**:
1. 打开浏览器开发者工具
2. 检查Network标签的请求
3. 确认请求URL: `DELETE /api/students/batch`
4. 验证请求body格式: `[1, 2, 3]`

### 问题5: 导入功能失败
**症状**: 导入CSV文件后报错

**解决**:
1. 确保CSV文件使用UTF-8编码
2. 验证CSV格式与模板一致
3. 检查必填字段是否完整（name, studentNumber）
4. 查看浏览器控制台错误信息

---

## 📊 性能优化建议

### 数据库优化
```sql
-- 为常用查询字段添加索引
CREATE INDEX idx_student_grade_class ON students(grade_level, class);
CREATE INDEX idx_student_major ON students(major);

-- 分析表性能
ANALYZE TABLE students;
```

### 后端优化
```properties
# application.properties

# 连接池配置
spring.datasource.hikari.maximum-pool-size=20
spring.datasource.hikari.minimum-idle=5

# JPA性能优化
spring.jpa.properties.hibernate.jdbc.batch_size=20
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true
```

---

## 📝 开发模式

### 前端开发
```bash
cd frontend
# 前端文件修改会自动刷新（Flask开发服务器）
python server.py
```

### 后端开发
```bash
cd backend
# 使用spring-boot-devtools自动重启
mvn spring-boot:run
```

### 数据库开发
```bash
# 测试SQL查询
mysql -u root -p student_analysis_system

# 快速重置数据库
cd database
mysql -u root -p < schema.sql
```

---

## 🐛 调试技巧

### 查看后端日志
```bash
# 日志位置
tail -f backend/logs/application.log

# 或在application.properties中设置
logging.level.com.example.studentanalysissystem=DEBUG
```

### 浏览器调试
1. 按F12打开开发者工具
2. Network标签查看API请求
3. Console标签查看JavaScript错误
4. 使用React DevTools（如果适用）

### API测试
使用Postman或curl测试API:
```bash
# 测试高级筛选
curl "http://localhost:8080/api/students/filter?gradeLevel=2024"

# 测试批量删除
curl -X DELETE http://localhost:8080/api/students/batch \
  -H "Content-Type: application/json" \
  -d '[1,2,3]'
```

---

## 📚 相关文档

- 📖 [完整更新总结](UPDATE_SUMMARY.md)
- 📖 [API文档](backend/API_DOCUMENTATION.md)
- 📖 [学生管理功能说明](frontend/STUDENT_MANAGEMENT_FEATURES.md)
- 📖 [功能对比文档](frontend/FEATURE_COMPARISON.md)
- 📖 [数据库指南](database/DATABASE_GUIDE.md)

---

## 🎯 下一步

完成基础设置后，您可以：

1. **熟悉系统**: 浏览各个功能模块
2. **添加数据**: 使用导入功能批量添加学生
3. **自定义配置**: 修改主题、筛选选项等
4. **扩展功能**: 参考API文档开发新功能
5. **性能调优**: 根据实际使用情况优化

---

## 💬 获取帮助

遇到问题？
- 📖 查看文档
- 🐛 检查GitHub Issues
- 💡 联系开发团队

---

**祝您使用愉快！** 🎉

---

**版本**: v2.0.0  
**最后更新**: 2024年10月5日
