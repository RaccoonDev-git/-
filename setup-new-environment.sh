#!/bin/bash

# 新环境快速设置脚本
# 适用于Linux/macOS

echo "=== 学生学情分析系统 - 新环境设置 ==="

# 检查必要软件
echo -e "\n1. 检查必要软件..."

# 检查Java
if command -v java &> /dev/null; then
    java_version=$(java -version 2>&1 | head -n 1)
    echo "✓ Java: $java_version"
else
    echo "✗ Java未安装或未配置PATH"
    echo "请安装Java 17或更高版本"
    exit 1
fi

# 检查Maven
if command -v mvn &> /dev/null; then
    maven_version=$(mvn -version 2>&1 | head -n 1)
    echo "✓ Maven: $maven_version"
else
    echo "✗ Maven未安装或未配置PATH"
    echo "请安装Maven"
    exit 1
fi

# 检查MySQL
if command -v mysql &> /dev/null; then
    mysql_version=$(mysql --version 2>&1 | head -n 1)
    echo "✓ MySQL: $mysql_version"
else
    echo "✗ MySQL未安装或未配置PATH"
    echo "请安装MySQL 8.0或更高版本"
    exit 1
fi

# 检查Python
if command -v python3 &> /dev/null; then
    python_version=$(python3 --version 2>&1)
    echo "✓ Python: $python_version"
elif command -v python &> /dev/null; then
    python_version=$(python --version 2>&1)
    echo "✓ Python: $python_version"
else
    echo "✗ Python未安装或未配置PATH"
    echo "请安装Python 3.7或更高版本"
    exit 1
fi

echo -e "\n2. 设置数据库..."

# 提示用户输入MySQL密码
read -s -p "请输入MySQL root密码: " mysql_password
echo

# 创建数据库
echo "创建数据库..."
mysql -u root -p$mysql_password -e "CREATE DATABASE IF NOT EXISTS student_analysis CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

if [ $? -eq 0 ]; then
    echo "✓ 数据库创建成功"
else
    echo "✗ 数据库创建失败"
    echo "请检查MySQL密码是否正确"
    exit 1
fi

# 导入数据库
echo "导入数据库结构和数据..."
if [ -f "database_migration.sql" ]; then
    mysql -u root -p$mysql_password student_analysis < database_migration.sql
    if [ $? -eq 0 ]; then
        echo "✓ 数据库导入成功"
    else
        echo "✗ 数据库导入失败"
        exit 1
    fi
else
    echo "✗ 找不到database_migration.sql文件"
    echo "请确保在项目根目录运行此脚本"
    exit 1
fi

echo -e "\n3. 配置应用..."

# 更新数据库配置
config_file="backend/src/main/resources/application.properties"
if [ -f "$config_file" ]; then
    echo "更新数据库连接配置..."
    
    # 备份原文件
    cp "$config_file" "$config_file.backup"
    
    # 更新配置
    cat > "$config_file" << EOF
# 数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/student_analysis?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
spring.datasource.username=root
spring.datasource.password=$mysql_password
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
EOF
    
    echo "✓ 应用配置更新成功"
else
    echo "✗ 找不到配置文件: $config_file"
fi

echo -e "\n4. 编译应用..."

# 编译后端
echo "编译后端应用..."
cd backend
if mvn clean compile; then
    echo "✓ 后端编译成功"
else
    echo "✗ 后端编译失败"
    cd ..
    exit 1
fi
cd ..

echo -e "\n5. 安装前端依赖..."

# 安装前端依赖
cd frontend
if [ -f "requirements.txt" ]; then
    echo "安装Python依赖..."
    if pip3 install -r requirements.txt 2>/dev/null || pip install -r requirements.txt; then
        echo "✓ 前端依赖安装成功"
    else
        echo "✗ 前端依赖安装失败"
        cd ..
        exit 1
    fi
fi
cd ..

echo -e "\n6. 验证设置..."

# 测试数据库连接
echo "测试数据库连接..."
if mysql -u root -p$mysql_password -e "USE student_analysis; SELECT COUNT(*) as table_count FROM information_schema.tables WHERE table_schema = 'student_analysis';" &> /dev/null; then
    echo "✓ 数据库连接正常"
else
    echo "✗ 数据库连接异常"
fi

echo -e "\n=== 设置完成 ==="
echo -e "\n下一步操作:"
echo "1. 启动后端: cd backend && mvn spring-boot:run"
echo "2. 启动前端: cd frontend && python3 server.py"
echo "3. 访问应用: http://localhost:5000"
echo -e "\n默认登录账号:"
echo "- 管理员: admin / password123"
echo "- 教师: teacher1 / password123"
echo "- 学生: student1 / password123"

echo -e "\n按任意键退出..."
read -n 1 -s
