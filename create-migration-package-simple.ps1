# 创建迁移包脚本 - 简化版

Write-Host "Creating migration package..." -ForegroundColor Green

# 创建迁移目录
$migrationDir = "migration-package-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
New-Item -ItemType Directory -Path $migrationDir -Force

Write-Host "Created migration directory: $migrationDir" -ForegroundColor Yellow

# 复制核心文件
Write-Host "Copying core files..." -ForegroundColor Yellow

# 后端代码
Write-Host "Copying backend code..." -ForegroundColor Cyan
Copy-Item -Path "backend" -Destination "$migrationDir\backend" -Recurse -Force

# 前端代码
Write-Host "Copying frontend code..." -ForegroundColor Cyan
Copy-Item -Path "frontend" -Destination "$migrationDir\frontend" -Recurse -Force

# 数据库文件
Write-Host "Copying database files..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path "$migrationDir\database" -Force
Copy-Item -Path "database\*.sql" -Destination "$migrationDir\database\" -Force
Copy-Item -Path "database\*.csv" -Destination "$migrationDir\database\" -Force
Copy-Item -Path "database\*.xlsx" -Destination "$migrationDir\database\" -Force
Copy-Item -Path "database\*.json" -Destination "$migrationDir\database\" -Force

# 配置文件
Write-Host "Copying config files..." -ForegroundColor Cyan
Copy-Item -Path "*.md" -Destination "$migrationDir\" -Force
Copy-Item -Path "*.ps1" -Destination "$migrationDir\" -Force
Copy-Item -Path "*.sh" -Destination "$migrationDir\" -Force

# 复制数据库迁移文件
if (Test-Path "database_migration.sql") {
    Copy-Item -Path "database_migration.sql" -Destination "$migrationDir\" -Force
    Write-Host "Database migration file copied" -ForegroundColor Green
} else {
    Write-Host "Database migration file not found" -ForegroundColor Red
}

# 创建压缩包
Write-Host "Creating zip package..." -ForegroundColor Yellow

$zipFile = "student-analysis-migration-$(Get-Date -Format 'yyyyMMdd-HHmmss').zip"
if (Get-Command Compress-Archive -ErrorAction SilentlyContinue) {
    Compress-Archive -Path "$migrationDir\*" -DestinationPath $zipFile -Force
    Write-Host "Zip package created: $zipFile" -ForegroundColor Green
} else {
    Write-Host "Cannot create zip package, please manually compress $migrationDir directory" -ForegroundColor Red
}

# 显示文件大小
$dirSize = (Get-ChildItem -Path $migrationDir -Recurse | Measure-Object -Property Length -Sum).Sum
$dirSizeMB = [math]::Round($dirSize / 1MB, 2)
Write-Host "Migration package size: $dirSizeMB MB" -ForegroundColor Cyan

Write-Host "Migration package creation completed!" -ForegroundColor Green
Write-Host "Migration package location: $migrationDir" -ForegroundColor Yellow
if (Test-Path $zipFile) {
    Write-Host "Zip package location: $zipFile" -ForegroundColor Yellow
}

Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Copy migration package to new computer" -ForegroundColor Cyan
Write-Host "2. Extract migration package" -ForegroundColor Cyan
Write-Host "3. Run setup script" -ForegroundColor Cyan
Write-Host "4. Start application" -ForegroundColor Cyan
