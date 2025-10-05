# 消息聊天功能使用指南

## 功能概述

本系统实现了完整的师生消息聊天功能,支持实时消息发送、接收、已读状态管理等功能。

## 已完成的功能

### 后端实现 ✅

1. **数据模型** (`Message.java`)

   - 消息 ID、发送者、接收者
   - 消息内容、类型(文本/图片/文件)
   - 已读状态、创建时间、读取时间

2. **数据访问层** (`MessageRepository.java`)

   - 10 个自定义查询方法
   - 支持复杂的聊天记录查询
   - 优化的数据库索引

3. **业务逻辑层** (`MessageService.java` + `MessageServiceImpl.java`)

   - 发送消息
   - 获取聊天记录
   - 获取聊天列表
   - 标记已读
   - 删除消息
   - 获取未读数量

4. **REST API** (`MessageController.java`)

   - 8 个 RESTful 端点
   - 支持跨域请求(CORS)
   - 完整的错误处理

5. **数据库结构**
   - `messages` 表已创建
   - 5 个索引优化查询性能
   - 外键约束确保数据完整性

### 前端实现 ✅

1. **UI 集成** (`dashboard.html`)

   - 聊天列表展示
   - 消息对话界面
   - 实时消息刷新
   - 未读消息徽章

2. **功能特性**
   - 自动加载聊天列表
   - 实时获取聊天记录
   - 发送消息功能
   - 自动标记已读
   - 每 5 秒自动刷新消息
   - 搜索聊天对象

## 部署步骤

### 1. 数据库迁移

```powershell
# 创建消息表
mysql -u root --password="" student_analysis < database/migration/002_create_messages_table.sql

# (可选) 插入测试数据
mysql -u root --password="" student_analysis < database/insert-test-messages.sql
```

### 2. 启动后端服务

```powershell
cd backend
mvn spring-boot:run
```

后端将运行在: `http://localhost:8082`

### 3. 启动前端服务

```powershell
cd frontend
python server.py
```

前端将运行在: `http://localhost:5000`

## API 文档

### 基础 URL

```
http://localhost:8082/api/messages
```

### 主要端点

#### 1. 发送消息

```http
POST /api/messages?senderId={senderId}
Content-Type: application/json

{
  "receiverId": 2,
  "content": "你好",
  "messageType": "text"
}
```

#### 2. 获取聊天列表

```http
GET /api/messages/chat-list?userId={userId}
```

返回:

- 聊天对象列表
- 最后一条消息
- 未读消息数量

#### 3. 获取聊天记录

```http
GET /api/messages/chat-history?userId1={userId1}&userId2={userId2}
```

返回两个用户之间的完整聊天记录,按时间升序排列。

#### 4. 标记所有消息为已读

```http
PUT /api/messages/read-all?userId={userId}&partnerId={partnerId}
```

#### 5. 获取未读消息数量

```http
GET /api/messages/unread-count?userId={userId}
```

更多 API 详情请参考: `backend/API_DOCUMENTATION.md`

## 使用说明

### 教师端使用

1. **登录系统**

   - 访问 `http://localhost:5000/src/pages/teacher/dashboard.html`
   - 使用教师账号登录

2. **查看聊天列表**

   - 左侧显示所有聊天对象
   - 红色徽章显示未读消息数量
   - 点击聊天项查看对话

3. **发送消息**

   - 选择聊天对象
   - 在底部输入框输入消息
   - 点击发送按钮或按 Enter 键发送

4. **搜索聊天**
   - 使用顶部搜索框
   - 输入学生姓名进行筛选

### 学生端使用

学生端集成方式与教师端相同,需要在学生页面中添加类似的聊天组件。

## 配置说明

### 前端配置

在 `dashboard.html` 中的配置项:

```javascript
// API基础URL
const API_BASE_URL = "http://localhost:8082/api";

// 自动刷新间隔(毫秒)
chatUpdateInterval = setInterval(() => {
  loadChatHistory(partnerId, false);
}, 5000); // 每5秒刷新一次
```

### 后端配置

在 `application.properties` 中:

```properties
# 服务端口
server.port=8082

# 数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis
spring.datasource.username=root
spring.datasource.password=

# CORS配置
cors.allowed.origins=*
```

## 测试数据

已提供测试数据 SQL 脚本: `database/insert-test-messages.sql`

测试数据包括:

- 用户 1 ↔ 用户 2 的对话(4 条消息)
- 用户 3 → 用户 1 的消息(3 条消息)
- 用户 4 ↔ 用户 2 的对话(3 条消息)

## 技术特点

### 性能优化

- 数据库索引优化查询速度
- 前端防抖处理搜索请求
- 自动刷新采用静默加载模式
- 分页加载(后续可扩展)

### 用户体验

- 实时消息更新
- 未读消息提醒
- 平滑滚动到最新消息
- 加载状态提示

### 安全性

- 用户权限验证
- XSS 防护
- CORS 跨域配置
- 参数验证

## 后续增强功能

### 计划中的功能

1. ⏳ WebSocket 实时推送
2. ⏳ 图片/文件上传
3. ⏳ 消息撤回功能
4. ⏳ 消息搜索功能
5. ⏳ 表情包支持
6. ⏳ 语音消息
7. ⏳ 消息通知(浏览器通知)
8. ⏳ 聊天记录导出

### 性能优化

- 消息分页加载
- 虚拟滚动(长列表优化)
- 图片懒加载
- 缓存策略

## 故障排除

### 常见问题

1. **无法加载聊天列表**

   - 检查后端服务是否启动
   - 确认数据库连接正常
   - 检查浏览器控制台错误信息

2. **消息发送失败**

   - 确认用户 ID 是否正确
   - 检查网络请求是否被拦截
   - 查看后端日志错误信息

3. **未读消息不更新**

   - 检查自动刷新是否启动
   - 确认标记已读 API 是否成功调用
   - 刷新页面重新加载

4. **样式显示异常**
   - 清除浏览器缓存
   - 检查 CSS 文件是否正确加载
   - 确认浏览器兼容性

## 联系支持

如有问题,请查看:

- 后端日志: `backend/logs/application.log`
- 浏览器控制台错误信息
- API 文档: `backend/API_DOCUMENTATION.md`

## 版本信息

- **版本**: v1.0
- **更新日期**: 2025 年 10 月 5 日
- **维护团队**: Student Learning Analysis System

---

**提示**: 首次使用建议先插入测试数据进行功能验证。
