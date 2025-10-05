@echo off
REM 启动前端服务器
REM 使用方法: 双击此文件

echo ======================================
echo   学情分析系统 - 前端启动脚本
echo ======================================
echo.

REM 检查Python
echo [1/4] 检查Python环境...
python --version >nul 2>&1
if errorlevel 1 (
    echo 错误: 未找到Python,请先安装Python 3.7+
    echo 下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)
python --version
echo OK - Python已安装
echo.

REM 检查依赖
echo [2/4] 检查依赖包...
pip show Flask >nul 2>&1
if errorlevel 1 (
    echo 缺少Flask,正在安装...
    pip install Flask requests
    if errorlevel 1 (
        echo 错误: 依赖安装失败
        pause
        exit /b 1
    )
)
echo OK - Flask和requests已安装
echo.

REM 检查后端
echo [3/4] 检查后端服务...
curl -s http://localhost:8082/actuator/health >nul 2>&1
if errorlevel 1 (
    echo 警告: 后端服务未运行或无法连接
    echo 请确保后端已启动: cd backend ^&^& mvn spring-boot:run
) else (
    echo OK - 后端服务运行正常 ^(端口8082^)
)
echo.

REM 启动前端
echo [4/4] 启动前端服务...
echo.
echo ======================================
echo   前端服务启动中...
echo   前端地址: http://localhost:3000
echo   API代理:  http://localhost:3000/api/* -^> http://localhost:8082/api/*
echo   按 Ctrl+C 停止服务
echo ======================================
echo.

python server.py

pause
