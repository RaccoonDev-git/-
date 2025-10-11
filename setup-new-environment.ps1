# 新环境快速设置脚本
# 适用于Windows PowerShell

Write-Host "=== 学生学情分析系统 - 新环境设置 ===" -ForegroundColor Green

# 检查必要软件
Write-Host "`n1. 检查必要软件..." -ForegroundColor Yellow

# 检查Java
try {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "✓ Java: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Java未安装或未配置PATH" -ForegroundColor Red
    Write-Host "请安装Java 17或更高版本" -ForegroundColor Red
    exit 1
}

# 检查Maven
try {
    $mavenVersion = mvn -version 2>&1 | Select-String "Apache Maven"
    Write-Host "✓ Maven: $mavenVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Maven未安装或未配置PATH" -ForegroundColor Red
    Write-Host "请安装Maven" -ForegroundColor Red
    exit 1
}

# 检查MySQL
try {
    $mysqlVersion = mysql --version 2>&1 | Select-String "mysql"
    Write-Host "✓ MySQL: $mysqlVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ MySQL未安装或未配置PATH" -ForegroundColor Red
    Write-Host "请安装MySQL 8.0或更高版本" -ForegroundColor Red
    exit 1
}

# 检查Python
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Python未安装或未配置PATH" -ForegroundColor Red
    Write-Host "请安装Python 3.7或更高版本" -ForegroundColor Red
    exit 1
}

Write-Host "`n2. 设置数据库..." -ForegroundColor Yellow

# 提示用户输入MySQL密码
$mysqlPassword = Read-Host "请输入MySQL root密码"

# 创建数据库
Write-Host "创建数据库..." -ForegroundColor Cyan
$createDbSql = @"
CREATE DATABASE IF NOT EXISTS student_analysis CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
"@

try {
    echo $createDbSql | mysql -u root -p$mysqlPassword
    Write-Host "✓ 数据库创建成功" -ForegroundColor Green
} catch {
    Write-Host "✗ 数据库创建失败" -ForegroundColor Red
    Write-Host "请检查MySQL密码是否正确" -ForegroundColor Red
    exit 1
}

# 导入数据库
Write-Host "导入数据库结构和数据..." -ForegroundColor Cyan
if (Test-Path "database_migration.sql") {
    try {
        mysql -u root -p$mysqlPassword student_analysis < database_migration.sql
        Write-Host "✓ 数据库导入成功" -ForegroundColor Green
    } catch {
        Write-Host "✗ 数据库导入失败" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✗ 找不到database_migration.sql文件" -ForegroundColor Red
    Write-Host "请确保在项目根目录运行此脚本" -ForegroundColor Red
    exit 1
}

Write-Host "`n3. 配置应用..." -ForegroundColor Yellow

# 更新数据库配置
$configFile = "backend\src\main\resources\application.properties"
if (Test-Path $configFile) {
    Write-Host "更新数据库连接配置..." -ForegroundColor Cyan
    
    # 备份原文件
    Copy-Item $configFile "$configFile.backup"
    
    # 更新配置
    $configContent = @"
# 数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
spring.datasource.username=root
spring.datasource.password=$mysqlPassword
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# JPA配置
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
spring.jpa.properties.hibernate.format_sql=true

# Jackson配置 - 解决Hibernate代理序列化问题
spring.jackson.serialization.fail-on-empty-beans=false
spring.jackson.default-property-inclusion=non_null

# 日志配置
logging.level.com.example.studentanalysissystem=INFO
logging.level.org.springframework.security=DEBUG
logging.file.name=logs/application.log
"@
    
    $configContent | Out-File -FilePath $configFile -Encoding UTF8
    Write-Host "✓ 应用配置更新成功" -ForegroundColor Green
} else {
    Write-Host "✗ 找不到配置文件: $configFile" -ForegroundColor Red
}

Write-Host "`n4. 编译应用..." -ForegroundColor Yellow

# 编译后端
Write-Host "编译后端应用..." -ForegroundColor Cyan
Set-Location backend
try {
    mvn clean compile
    Write-Host "✓ 后端编译成功" -ForegroundColor Green
} catch {
    Write-Host "✗ 后端编译失败" -ForegroundColor Red
    Set-Location ..
    exit 1
}
Set-Location ..

Write-Host "`n5. 安装前端依赖..." -ForegroundColor Yellow

# 安装前端依赖
Set-Location frontend
if (Test-Path "requirements.txt") {
    Write-Host "安装Python依赖..." -ForegroundColor Cyan
    try {
        pip install -r requirements.txt
        Write-Host "✓ 前端依赖安装成功" -ForegroundColor Green
    } catch {
        Write-Host "✗ 前端依赖安装失败" -ForegroundColor Red
        Set-Location ..
        exit 1
    }
}
Set-Location ..

Write-Host "`n6. 验证设置..." -ForegroundColor Yellow

# 测试数据库连接
Write-Host "测试数据库连接..." -ForegroundColor Cyan
try {
    $testResult = mysql -u root -p$mysqlPassword -e "USE student_analysis; SELECT COUNT(*) as table_count FROM information_schema.tables WHERE table_schema = 'student_analysis';" 2>&1
    if ($testResult -match "table_count") {
        Write-Host "✓ 数据库连接正常" -ForegroundColor Green
    } else {
        Write-Host "✗ 数据库连接异常" -ForegroundColor Red
    }
} catch {
    Write-Host "✗ 数据库连接测试失败" -ForegroundColor Red
}

Write-Host "`n=== 设置完成 ===" -ForegroundColor Green
Write-Host "`n下一步操作:" -ForegroundColor Yellow
Write-Host "1. 启动后端: cd backend && mvn spring-boot:run" -ForegroundColor Cyan
Write-Host "2. 启动前端: cd frontend && python server.py" -ForegroundColor Cyan
Write-Host "3. 访问应用: http://localhost:5000" -ForegroundColor Cyan
Write-Host "`n默认登录账号:" -ForegroundColor Yellow
Write-Host "- 管理员: admin / password123" -ForegroundColor Cyan
Write-Host "- 教师: teacher1 / password123" -ForegroundColor Cyan
Write-Host "- 学生: student1 / password123" -ForegroundColor Cyan

Write-Host "`n按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
