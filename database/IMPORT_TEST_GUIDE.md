# 用户批量导入测试数据说明

## 快速开始

由于需要 openpyxl 库,建议使用以下两种方式生成测试 Excel:

### 方式 1: 手动创建 Excel(推荐)

1. 打开 Excel/WPS 新建文件
2. 第一行填写标题:
   ```
   用户名 | 密码 | 角色 | 邮箱 | 手机
   ```
3. 从第二行开始填写数据,例如:
   ```
   test_student01 | pass123456 | STUDENT | test01@example.com | 13800001001
   test_student02 | pass123456 | STUDENT | test02@example.com | 13800001002
   test_teacher01 | pass123456 | TEACHER | tea01@example.com  | 13800002001
   ```
4. 另存为`.xlsx`格式

### 方式 2: 使用 Python 生成(需安装依赖)

```bash
# 安装依赖
pip install openpyxl

# 运行生成脚本
python database/generate-import-test-excel.py
```

## 快速测试数据

复制以下数据到 Excel 进行测试:

| 用户名         | 密码       | 角色    | 邮箱                   | 手机        |
| -------------- | ---------- | ------- | ---------------------- | ----------- |
| test_student01 | pass123456 | STUDENT | test_stu01@example.com | 13800001001 |
| test_student02 | pass123456 | STUDENT | test_stu02@example.com | 13800001002 |
| test_student03 | pass123456 | STUDENT | test_stu03@example.com | 13800001003 |
| test_teacher01 | pass123456 | TEACHER | test_tea01@example.com | 13800002001 |
| test_admin01   | pass123456 | ADMIN   | test_adm01@example.com | 13800003001 |

## 错误测试数据

用于测试错误处理:

| 用户名       | 密码       | 角色    | 邮箱                | 手机        |
| ------------ | ---------- | ------- | ------------------- | ----------- |
|              | pass123    | STUDENT | test@example.com    | 13800000001 |
| error_user1  |            | STUDENT | test@example.com    | 13800000002 |
| error_user2  | pass123    |         | test@example.com    | 13800000003 |
| error_user3  | pass123    | INVALID | test@example.com    | 13800000004 |
| normal_user1 | pass123456 | STUDENT | normal1@example.com | 13800000005 |

预期结果:

- 前 4 行失败(空字段/无效角色)
- 第 5 行成功
- 显示详细错误信息

## 测试步骤

1. **准备测试数据**

   - 创建 Excel 文件
   - 填入上述测试数据
   - 保存为`.xlsx`格式

2. **执行导入**

   - 启动后端服务: `cd backend && mvn spring-boot:run`
   - 打开前端: http://localhost:3000/user-management.html
   - 使用 admin 账号登录
   - 点击"批量导入"按钮
   - 选择 Excel 文件

3. **验证结果**
   - 查看导入统计(总行数、成功数、失败数)
   - 检查错误详情列表
   - 在用户列表中确认新增用户
   - 验证用户信息正确性

## 注意事项

⚠️ **测试前须知**:

1. 确保用户名不与现有用户重复
2. 首次测试建议使用 5 条以内数据
3. 测试完成后可在用户管理页面删除测试用户
4. 建议在测试环境数据库中测试

## API 测试(Postman/curl)

```bash
# 使用curl测试导入接口
curl -X POST http://localhost:8082/api/admin/users/import \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "file=@/path/to/your/test.xlsx"
```

预期响应:

```json
{
  "success": true,
  "successCount": 5,
  "failCount": 0,
  "totalRows": 5,
  "errors": []
}
```
