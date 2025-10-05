# =============================================
# 插入测试数据到数据库
# =============================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  插入测试数据" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 数据库配置
$DB_NAME = "student_analysis"
$DB_USER = "root"
$DB_HOST = "localhost"
$DB_PORT = 3306

# 提示输入密码
Write-Host "请输入 MySQL root 用户密码 (直接回车表示无密码):" -ForegroundColor Yellow
$password = Read-Host -AsSecureString
$plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

Write-Host ""
Write-Host "开始插入测试数据..." -ForegroundColor Yellow
Write-Host ""

$testDataFile = Join-Path $PSScriptRoot "insert-test-data.sql"

if (-not (Test-Path $testDataFile)) {
    Write-Host "? 找不到 insert-test-data.sql 文件" -ForegroundColor Red
    exit 1
}

# 执行插入脚本
if ([string]::IsNullOrEmpty($plainPassword)) {
    & cmd /c "mysql -h $DB_HOST -P $DB_PORT -u $DB_USER $DB_NAME < `"$testDataFile`" 2>&1"
} else {
    & cmd /c "mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$plainPassword $DB_NAME < `"$testDataFile`" 2>&1"
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "? 插入测试数据失败" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ? 测试数据插入完成!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "测试账号信息:" -ForegroundColor Cyan
Write-Host ""
Write-Host "【管理员账号】" -ForegroundColor Yellow
Write-Host "  用户名: admin" -ForegroundColor White
Write-Host "  密码:   password123" -ForegroundColor White
Write-Host ""
Write-Host "【教师账号】" -ForegroundColor Yellow
Write-Host "  用户名: teacher1 / teacher2 / teacher3" -ForegroundColor White
Write-Host "  密码:   password123" -ForegroundColor White
Write-Host ""
Write-Host "【学生账号】" -ForegroundColor Yellow
Write-Host "  用户名: student1 / student2 / student3 / student4 / student5" -ForegroundColor White
Write-Host "  密码:   password123" -ForegroundColor White
Write-Host ""
Write-Host "测试数据包括:" -ForegroundColor Cyan
Write-Host "  ? 9 个用户 (1管理员 + 3教师 + 5学生)" -ForegroundColor Green
Write-Host "  ? 3 位教师详细信息" -ForegroundColor Green
Write-Host "  ? 5 位学生详细信息" -ForegroundColor Green
Write-Host "  ? 5 门课程" -ForegroundColor Green
Write-Host "  ? 16 条选课记录" -ForegroundColor Green
Write-Host "  ? 17 条成绩记录" -ForegroundColor Green
Write-Host "  ? 9 条学习活动记录" -ForegroundColor Green
Write-Host "  ? 5 条通知信息" -ForegroundColor Green
Write-Host ""
Write-Host "现在可以启动系统进行测试!" -ForegroundColor Cyan
Write-Host ""
