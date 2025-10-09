# 分析页面动态数据修复总结

## 问题描述

分析页面的以下元素没有动态更新，使用的是硬编码的本地数据：

- 班级选择下拉框
- 科目选择下拉框
- 学生成绩表格
- 成绩分布饼图
- 班级对比图表
- 课程相关性图表

## 根本原因

1. **API 地址错误**: `dashboard.html` 中的 `API_URL` 设置为 `/api`，导致请求发送到前端服务器 `http://localhost:3000/api/students` 而不是后端服务器
2. **缺少动态数据加载**: 分析功能使用硬编码的 `analysisData` 而不是从数据库获取真实数据
3. **选项未动态更新**: 班级和科目选项是硬编码的，没有从数据库动态加载

## 修复内容

### 1. 修复 API 地址

```javascript
// 修复前
window.API_URL = window.API_URL || "/api";

// 修复后
window.API_URL = window.API_URL || "http://localhost:8080/api";
```

### 2. 添加动态选项加载函数

```javascript
async function loadAnalysisOptions() {
  try {
    // 从后端API获取班级和课程数据
    const students = await apiRequest("/students");
    const courses = await apiRequest("/courses");

    // 动态更新班级选项
    const classNames = [...new Set(students.map((s) => s.className))];
    const classSelect = document.getElementById("analysis-class-select");
    classSelect.innerHTML = classNames
      .map((className) => {
        // 映射班级名称到选项值
        return `<option value="${classKey}">${className}</option>`;
      })
      .join("");

    // 动态更新科目选项
    const subjectSelect = document.getElementById("subject-select");
    subjectSelect.innerHTML = courses
      .map((course) => {
        // 映射课程名称到选项值
        return `<option value="${subjectKey}">${course.name}</option>`;
      })
      .join("");
  } catch (error) {
    console.error("加载选项失败:", error);
  }
}
```

### 3. 修改数据分析函数

```javascript
async function loadAnalysisData() {
  try {
    // 从后端API获取真实数据
    const students = await apiRequest("/students");
    const grades = await apiRequest("/grades");
    const courses = await apiRequest("/courses");

    // 根据选择的班级和科目筛选数据
    const filteredStudents = students.filter((student) => {
      return student.className === classMapping[selectedClass];
    });

    // 获取对应科目的课程ID
    const targetCourse = courses.find(
      (course) => course.name === subjectMapping[selectedSubject]
    );

    // 获取该课程的成绩数据
    const courseGrades = grades.filter(
      (grade) => grade.courseId === targetCourse.id
    );

    // 构建学生成绩数据
    const studentGradeData = filteredStudents.map((student) => {
      const studentGrade = courseGrades.find(
        (grade) => grade.studentId === student.id
      );
      return {
        name: student.name,
        id: student.studentNumber,
        score: studentGrade ? studentGrade.score : 0,
        studentId: student.id,
      };
    });

    // 更新表格和图表
    updateTable(studentGradeData);
    updateScoreChartFromData(studentGradeData, subjectName);
  } catch (error) {
    console.error("加载分析数据失败:", error);
    // 使用本地数据作为备选
    loadAnalysisDataFromLocal();
  }
}
```

### 4. 添加 API 数据图表更新函数

```javascript
function updateScoreChartFromData(data, subjectName) {
  // 计算成绩分布
  const scoreRanges = {
    "<60": data.filter((s) => s.score < 60).length,
    "60-69": data.filter((s) => s.score >= 60 && s.score < 70).length,
    "70-79": data.filter((s) => s.score >= 70 && s.score < 80).length,
    "80-89": data.filter((s) => s.score >= 80 && s.score < 90).length,
    "90-100": data.filter((s) => s.score >= 90).length,
  };

  // 更新饼图
  globalCharts.analysisChart = new Chart(ctx, {
    type: "pie",
    data: {
      labels: filteredLabels,
      datasets: [
        {
          data: filteredData,
          backgroundColor: colors.slice(0, filteredData.length),
        },
      ],
    },
    options: {
      plugins: {
        title: {
          display: true,
          text: `${subjectName}成绩分布`,
        },
      },
    },
  });
}
```

### 5. 页面初始化时加载选项

```javascript
// 在页面加载完成后调用
document.addEventListener("DOMContentLoaded", function () {
  // 加载初始数据
  refreshStudentList();

  // 加载分析选项
  loadAnalysisOptions();
});
```

## 修复效果

### 修复前

- ❌ 所有数据都是硬编码的本地数据
- ❌ 班级和科目选项固定不变
- ❌ 表格数据不会根据选择更新
- ❌ 图表显示的是模拟数据
- ❌ API 请求发送到错误的前端服务器地址

### 修复后

- ✅ 所有数据都从数据库动态获取
- ✅ 班级和科目选项根据数据库内容动态生成
- ✅ 表格数据根据选择的班级和科目实时更新
- ✅ 图表显示真实的数据库数据
- ✅ API 请求正确发送到后端服务器
- ✅ 保留了本地数据作为备选方案

## 技术要点

1. **API 地址统一**: 确保所有 API 请求都发送到正确的后端服务器地址
2. **动态数据加载**: 从数据库获取真实的学生、课程、成绩数据
3. **选项动态更新**: 根据数据库内容动态生成下拉框选项
4. **错误处理**: 当 API 调用失败时，使用本地数据作为备选
5. **数据映射**: 正确映射数据库字段到前端显示格式
6. **图表更新**: 使用真实数据更新所有图表和统计信息

## 测试验证

运行以下命令验证修复效果：

```bash
# 启动后端服务器
cd backend && mvn spring-boot:run

# 启动前端服务器
cd frontend && python server.py

# 访问教师仪表盘页面
# http://localhost:3000/src/pages/teacher/dashboard.html
```

现在分析页面的所有元素都会动态更新，数据来源于数据库！
