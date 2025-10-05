# =============================================
# 创建学生学习情况分析系统数据库
# =============================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  学生学习情况分析系统 - 数据库初始化" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 数据库配置
$DB_NAME = "student_analysis"
$DB_USER = "root"
$DB_HOST = "localhost"
$DB_PORT = 3306

# 检查 MySQL 是否安装
Write-Host "检查 MySQL 服务..." -ForegroundColor Yellow
$mysqlService = Get-Service -Name "MySQL*" -ErrorAction SilentlyContinue

if (-not $mysqlService) {
    Write-Host "? 未检测到 MySQL 服务" -ForegroundColor Red
    Write-Host "请先安装 MySQL 8.0 或更高版本" -ForegroundColor Red
    Write-Host "下载地址: https://dev.mysql.com/downloads/mysql/" -ForegroundColor Yellow
    exit 1
}

# 检查 MySQL 服务是否运行
if ($mysqlService.Status -ne "Running") {
    Write-Host "??  MySQL 服务未运行,正在尝试启动..." -ForegroundColor Yellow
    Start-Service $mysqlService.Name -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 3
    
    $mysqlService = Get-Service -Name $mysqlService.Name
    if ($mysqlService.Status -ne "Running") {
        Write-Host "? 无法启动 MySQL 服务" -ForegroundColor Red
        exit 1
    }
}

Write-Host "? MySQL 服务运行中" -ForegroundColor Green
Write-Host ""

# 提示输入密码
Write-Host "请输入 MySQL root 用户密码 (直接回车表示无密码):" -ForegroundColor Yellow
$password = Read-Host -AsSecureString
$plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

Write-Host ""
Write-Host "开始创建数据库..." -ForegroundColor Yellow
Write-Host ""

# 构建 MySQL 命令
if ([string]::IsNullOrEmpty($plainPassword)) {
    $mysqlCommand = "mysql -h $DB_HOST -P $DB_PORT -u $DB_USER"
} else {
    $mysqlCommand = "mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$plainPassword"
}

# 1. 创建数据库
Write-Host "步骤 1/3: 创建数据库 '$DB_NAME'..." -ForegroundColor Cyan
$createDbSql = @"
DROP DATABASE IF EXISTS $DB_NAME;
CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE $DB_NAME;
"@

$createDbSql | & cmd /c "$mysqlCommand 2>&1"

if ($LASTEXITCODE -ne 0) {
    Write-Host "? 创建数据库失败" -ForegroundColor Red
    Write-Host "请检查:" -ForegroundColor Yellow
    Write-Host "  1. MySQL 密码是否正确" -ForegroundColor Yellow
    Write-Host "  2. root 用户是否有足够权限" -ForegroundColor Yellow
    exit 1
}

Write-Host "? 数据库创建成功" -ForegroundColor Green
Write-Host ""

# 2. 执行数据库架构脚本
Write-Host "步骤 2/3: 创建数据表..." -ForegroundColor Cyan

$schemaFile = Join-Path $PSScriptRoot "schema.sql"

if (-not (Test-Path $schemaFile)) {
    Write-Host "? 找不到 schema.sql 文件" -ForegroundColor Red
    exit 1
}

if ([string]::IsNullOrEmpty($plainPassword)) {
    & cmd /c "mysql -h $DB_HOST -P $DB_PORT -u $DB_USER $DB_NAME < `"$schemaFile`" 2>&1"
} else {
    & cmd /c "mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$plainPassword $DB_NAME < `"$schemaFile`" 2>&1"
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "? 创建数据表失败" -ForegroundColor Red
    exit 1
}

Write-Host "? 数据表创建成功" -ForegroundColor Green
Write-Host ""

# 3. 验证数据库
Write-Host "步骤 3/3: 验证数据库..." -ForegroundColor Cyan

$verifyTablesQuery = @"
USE $DB_NAME;
SHOW TABLES;
"@

Write-Host ""
Write-Host "已创建的数据表:" -ForegroundColor Green
$verifyTablesQuery | & cmd /c "$mysqlCommand 2>&1"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ? 数据库初始化完成!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "数据库信息:" -ForegroundColor Cyan
Write-Host "  数据库名: $DB_NAME" -ForegroundColor White
Write-Host "  主机地址: $DB_HOST" -ForegroundColor White
Write-Host "  端口号:   $DB_PORT" -ForegroundColor White
Write-Host "  用户名:   $DB_USER" -ForegroundColor White
Write-Host ""
Write-Host "后端配置文件: backend/src/main/resources/application-mysql.properties" -ForegroundColor Yellow
Write-Host "请确认数据库密码配置正确!" -ForegroundColor Yellow
Write-Host ""
Write-Host "下一步: 启动后端服务" -ForegroundColor Cyan
Write-Host "  cd backend" -ForegroundColor White
Write-Host "  mvn spring-boot:run" -ForegroundColor White
Write-Host ""
