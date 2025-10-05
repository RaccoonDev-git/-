# 启动前端服务器
# 使用方法: 双击此文件或在PowerShell中运行 .\start-frontend.ps1

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  学情分析系统 - 前端启动脚本" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# 检查Python
Write-Host "[1/4] 检查Python环境..." -ForegroundColor Yellow
$pythonVersion = python --version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "错误: 未找到Python,请先安装Python 3.7+" -ForegroundColor Red
    Write-Host "下载地址: https://www.python.org/downloads/" -ForegroundColor Yellow
    pause
    exit 1
}
Write-Host "✓ Python已安装: $pythonVersion" -ForegroundColor Green
Write-Host ""

# 检查依赖
Write-Host "[2/4] 检查依赖包..." -ForegroundColor Yellow
$flaskInstalled = pip show Flask 2>&1 | Select-String -Pattern "Name: Flask" -Quiet
$requestsInstalled = pip show requests 2>&1 | Select-String -Pattern "Name: requests" -Quiet

if (-not $flaskInstalled -or -not $requestsInstalled) {
    Write-Host "缺少依赖包,正在安装..." -ForegroundColor Yellow
    pip install Flask requests
    if ($LASTEXITCODE -ne 0) {
        Write-Host "错误: 依赖安装失败" -ForegroundColor Red
        pause
        exit 1
    }
}
Write-Host "✓ Flask和requests已安装" -ForegroundColor Green
Write-Host ""

# 检查后端
Write-Host "[3/4] 检查后端服务..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8082/actuator/health" -TimeoutSec 2 -ErrorAction SilentlyContinue
    Write-Host "✓ 后端服务运行正常 (端口8082)" -ForegroundColor Green
} catch {
    Write-Host "⚠ 警告: 后端服务未运行或无法连接" -ForegroundColor Yellow
    Write-Host "  请确保后端已启动: cd backend && mvn spring-boot:run" -ForegroundColor Yellow
}
Write-Host ""

# 启动前端
Write-Host "[4/4] 启动前端服务..." -ForegroundColor Yellow
Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  前端服务启动中..." -ForegroundColor Cyan
Write-Host "  前端地址: http://localhost:3000" -ForegroundColor Green
Write-Host "  API代理:  http://localhost:3000/api/* -> http://localhost:8082/api/*" -ForegroundColor Green
Write-Host "  按 Ctrl+C 停止服务" -ForegroundColor Yellow
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# 启动Flask服务器
python server.py
