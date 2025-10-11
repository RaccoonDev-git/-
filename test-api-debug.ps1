# 测试API调试
Write-Host "=== API调试测试 ===" -ForegroundColor Green

$baseUrl = "http://localhost:8080"
$loginUrl = "$baseUrl/api/auth/login"

# 登录获取token
Write-Host "`n1. 登录获取token..." -ForegroundColor Cyan
$loginBody = @{
    username = "teacher1"
    password = "password123"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri $loginUrl -Method Post -Body $loginBody -ContentType "application/json"
    $token = $loginResponse.token
    Write-Host "登录成功" -ForegroundColor Green
} catch {
    Write-Host "登录失败: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

# 测试权重配置API
Write-Host "`n2. 测试权重配置API..." -ForegroundColor Cyan
try {
    $weightConfig = @{
        courseId = 1
        regularWeight = 30.00
        finalWeight = 70.00
        makeupWeight = 100.00
    } | ConvertTo-Json

    Write-Host "发送请求到: $baseUrl/api/course-weight-configs" -ForegroundColor Yellow
    Write-Host "请求数据: $weightConfig" -ForegroundColor Yellow
    
    $weightResponse = Invoke-RestMethod -Uri "$baseUrl/api/course-weight-configs" -Method Post -Body $weightConfig -Headers $headers
    Write-Host "✅ 权重配置API成功" -ForegroundColor Green
} catch {
    Write-Host "❌ 权重配置API失败" -ForegroundColor Red
    Write-Host "错误详情: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $stream = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $responseBody = $reader.ReadToEnd()
        Write-Host "响应内容: $responseBody" -ForegroundColor Red
    }
}

# 测试成绩类型API
Write-Host "`n3. 测试成绩类型API..." -ForegroundColor Cyan
try {
    $gradeTypes = @{
        gradeTypes = @(
            @{
                typeCode = "HOMEWORK"
                typeName = "作业"
                defaultWeight = 20.00
                isRegular = $true
                isActive = $true
                sortOrder = 1
            },
            @{
                typeCode = "QUIZ"
                typeName = "小测验"
                defaultWeight = 30.00
                isRegular = $true
                isActive = $true
                sortOrder = 2
            }
        )
    } | ConvertTo-Json -Depth 3

    Write-Host "发送请求到: $baseUrl/api/grade-types/batch" -ForegroundColor Yellow
    Write-Host "请求数据: $gradeTypes" -ForegroundColor Yellow
    
    $gradeTypesResponse = Invoke-RestMethod -Uri "$baseUrl/api/grade-types/batch" -Method Post -Body $gradeTypes -Headers $headers
    Write-Host "✅ 成绩类型API成功" -ForegroundColor Green
} catch {
    Write-Host "❌ 成绩类型API失败" -ForegroundColor Red
    Write-Host "错误详情: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $stream = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $responseBody = $reader.ReadToEnd()
        Write-Host "响应内容: $responseBody" -ForegroundColor Red
    }
}

Write-Host "`n=== 测试完成 ===" -ForegroundColor Green
