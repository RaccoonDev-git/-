# 创建迁移包脚本
# 将所有必要文件打包用于迁移

Write-Host "=== 创建数据库迁移包 ===" -ForegroundColor Green

# 创建迁移目录
$migrationDir = "migration-package-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
New-Item -ItemType Directory -Path $migrationDir -Force

Write-Host "创建迁移目录: $migrationDir" -ForegroundColor Yellow

# 复制核心文件
Write-Host "`n1. 复制核心文件..." -ForegroundColor Yellow

# 后端代码
Write-Host "复制后端代码..." -ForegroundColor Cyan
Copy-Item -Path "backend" -Destination "$migrationDir\backend" -Recurse -Force

# 前端代码
Write-Host "复制前端代码..." -ForegroundColor Cyan
Copy-Item -Path "frontend" -Destination "$migrationDir\frontend" -Recurse -Force

# 数据库文件
Write-Host "复制数据库文件..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path "$migrationDir\database" -Force
Copy-Item -Path "database\*.sql" -Destination "$migrationDir\database\" -Force
Copy-Item -Path "database\*.csv" -Destination "$migrationDir\database\" -Force
Copy-Item -Path "database\*.xlsx" -Destination "$migrationDir\database\" -Force
Copy-Item -Path "database\*.json" -Destination "$migrationDir\database\" -Force

# 配置文件
Write-Host "复制配置文件..." -ForegroundColor Cyan
Copy-Item -Path "*.md" -Destination "$migrationDir\" -Force
Copy-Item -Path "*.ps1" -Destination "$migrationDir\" -Force
Copy-Item -Path "*.sh" -Destination "$migrationDir\" -Force

# 复制数据库迁移文件
if (Test-Path "database_migration.sql") {
    Copy-Item -Path "database_migration.sql" -Destination "$migrationDir\" -Force
    Write-Host "✓ 数据库迁移文件已复制" -ForegroundColor Green
} else {
    Write-Host "✗ 找不到database_migration.sql文件" -ForegroundColor Red
}

# 创建README文件
Write-Host "`n2. 创建README文件..." -ForegroundColor Yellow

$readmeContent = @"
# 学生学情分析系统 - 迁移包

## 文件说明

### 核心文件
- `backend/` - 后端Spring Boot应用
- `frontend/` - 前端Python Flask应用
- `database/` - 数据库相关文件
- `database_migration.sql` - 完整数据库迁移文件

### 设置脚本
- `setup-new-environment.ps1` - Windows PowerShell设置脚本
- `setup-new-environment.sh` - Linux/macOS Bash设置脚本

### 文档
- `DATABASE_MIGRATION_GUIDE.md` - 详细迁移指南
- `README.md` - 项目说明文档

## 快速开始

### Windows
```powershell
.\setup-new-environment.ps1
```

### Linux/macOS
```bash
chmod +x setup-new-environment.sh
./setup-new-environment.sh
```

## 系统要求

- Java 17+
- Maven 3.6+
- MySQL 8.0+
- Python 3.7+

## 默认账号

- 管理员: admin / password123
- 教师: teacher1 / password123
- 学生: student1 / password123

## 注意事项

1. 确保MySQL服务正在运行
2. 确保端口8080和5000未被占用
3. 首次运行需要编译后端应用

## 技术支持

如遇问题，请检查：
1. 日志文件: backend/logs/application.log
2. 数据库连接状态
3. 应用配置是否正确

---
生成时间: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
"@

$readmeContent | Out-File -FilePath "$migrationDir\README-MIGRATION.md" -Encoding UTF8

# 创建压缩包
Write-Host "`n3. 创建压缩包..." -ForegroundColor Yellow

$zipFile = "student-analysis-migration-$(Get-Date -Format 'yyyyMMdd-HHmmss').zip"
if (Get-Command Compress-Archive -ErrorAction SilentlyContinue) {
    Compress-Archive -Path "$migrationDir\*" -DestinationPath $zipFile -Force
    Write-Host "✓ 压缩包创建成功: $zipFile" -ForegroundColor Green
} else {
    Write-Host "✗ 无法创建压缩包，请手动压缩 $migrationDir 目录" -ForegroundColor Red
}

# 显示文件大小
$dirSize = (Get-ChildItem -Path $migrationDir -Recurse | Measure-Object -Property Length -Sum).Sum
$dirSizeMB = [math]::Round($dirSize / 1MB, 2)
Write-Host "迁移包大小: $dirSizeMB MB" -ForegroundColor Cyan

Write-Host "`n=== 迁移包创建完成 ===" -ForegroundColor Green
Write-Host "迁移包位置: $migrationDir" -ForegroundColor Yellow
if (Test-Path $zipFile) {
    Write-Host "压缩包位置: $zipFile" -ForegroundColor Yellow
}

Write-Host "`n下一步操作:" -ForegroundColor Yellow
Write-Host "1. 将迁移包复制到新电脑" -ForegroundColor Cyan
Write-Host "2. 解压迁移包" -ForegroundColor Cyan
Write-Host "3. 运行设置脚本" -ForegroundColor Cyan
Write-Host "4. 启动应用" -ForegroundColor Cyan

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
Read-Host
