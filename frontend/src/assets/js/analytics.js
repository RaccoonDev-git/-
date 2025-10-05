// 数据分析模块
let chartInstances = [];

// 初始化分析模块
function initAnalytics() {
    // 加载分析数据
    loadAnalyticsData();
}

// 将初始化函数绑定到window对象
window.initAnalytics = initAnalytics;

// 切换分析类型的事件监听
const analysisTypeElement = document.getElementById('analysis-type');
if (analysisTypeElement) {
    analysisTypeElement.addEventListener('change', loadAnalyticsData);
}

// 加载分析数据
async function loadAnalyticsData() {
    const analysisType = document.getElementById('analysis-type').value;
    const analyticsContainer = document.getElementById('analytics-container');
    analyticsContainer.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i> 加载分析数据中...</div>';

    // 清除现有图表
    chartInstances.forEach(chart => chart.destroy());
    chartInstances = [];

    try {
        // 根据选择的分析类型加载不同的数据
        switch (analysisType) {
            case 'score-distribution':
                await renderScoreDistribution();
                break;
            case 'course-comparison':
                await renderCourseComparison();
                break;
            case 'student-trend':
                await renderStudentTrend();
                break;
            case 'correlation-analysis':
                await renderCorrelationAnalysis();
                break;
            default:
                await renderScoreDistribution();
        }
    } catch (error) {
        analyticsContainer.innerHTML = '<div class="error-message">分析数据加载失败，请重试</div>';
        console.error('Error loading analytics data:', error);
    }
}
// 渲染成绩分布图表
async function renderScoreDistribution() {
    try {
        const analyticsContainer = document.getElementById('analytics-container');
        analyticsContainer.innerHTML = `
            <h3>成绩分布分析</h3>
            <div class="chart-container">
                <canvas id="scoreDistributionChart"></canvas>
            </div>
            <div class="chart-info">
                <p>该图表显示了所有学生成绩的分布情况，帮助了解整体学习状况。</p>
            </div>
        `;

        // 获取成绩数据
        const scores = await apiRequest('scores');
    

    if (scores && scores.length > 0) {
        // 计算分数段
        const scoreBins = [0, 60, 70, 80, 90, 100];
        const binLabels = ['<60', '60-69', '70-79', '80-89', '90+'];
        const binCounts = new Array(binLabels.length).fill(0);

        scores.forEach(score => {
            if (score.scoreValue < 60) binCounts[0]++;
            else if (score.scoreValue < 70) binCounts[1]++;
            else if (score.scoreValue < 80) binCounts[2]++;
            else if (score.scoreValue < 90) binCounts[3]++;
            else binCounts[4]++;
        });

        // 创建图表
        const ctx = document.getElementById('scoreDistributionChart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: binLabels,
                datasets: [{
                    label: '学生数量',
                    data: binCounts,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(255, 159, 64, 0.7)',
                        'rgba(255, 205, 86, 0.7)',
                        'rgba(75, 192, 192, 0.7)',
                        'rgba(54, 162, 235, 0.7)'
                    ],
                    borderColor: [
                        'rgb(255, 99, 132)',
                        'rgb(255, 159, 64)',
                        'rgb(255, 205, 86)',
                        'rgb(75, 192, 192)',
                        'rgb(54, 162, 235)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        }
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: '成绩分布统计图',
                        font: {
                            size: 16
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `学生数量: ${context.raw}`;
                            }
                        }
                    }
                }
            }
        });

        chartInstances.push(chart);
    } else {
        analyticsContainer.innerHTML = '<div class="error-message">没有找到成绩数据</div>';
    }
    } catch (error) {
        const analyticsContainer = document.getElementById('analytics-container');
        analyticsContainer.innerHTML = '<div class="error-message">成绩分布分析加载失败，请重试</div>';
        console.error('Error loading score distribution:', error);
    }
// 渲染课程对比图表
async function renderCourseComparison() {
    const analyticsContainer = document.getElementById('analytics-container');
    analyticsContainer.innerHTML = `
        <h3>课程平均分对比</h3>
        <div class="chart-container">
            <canvas id="courseComparisonChart"></canvas>
        </div>
        <div class="chart-info">
            <p>该图表显示了各课程的平均分数对比，帮助了解不同课程的整体表现。</p>
        </div>
    `;

    try {
        // 获取课程和成绩数据
        const courses = await apiRequest('courses');
        const scores = await apiRequest('scores');

        if (courses && courses.length > 0 && scores && scores.length > 0) {
        // 计算每门课程的平均分
        const courseAverages = [];
        const courseLabels = [];

        courses.forEach(course => {
            const courseScores = scores.filter(score => score.courseId === course.id);
            if (courseScores.length > 0) {
                const totalScore = courseScores.reduce((sum, score) => sum + score.scoreValue, 0);
                const averageScore = totalScore / courseScores.length;
                courseAverages.push(averageScore);
                courseLabels.push(`${course.courseName} (${course.courseCode})`);
            }
        });

        // 创建图表
        const ctx = document.getElementById('courseComparisonChart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: courseLabels,
                datasets: [{
                    label: '平均分',
                    data: courseAverages,
                    backgroundColor: 'rgba(75, 192, 192, 0.7)',
                    borderColor: 'rgb(75, 192, 192)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        title: {
                            display: true,
                            text: '平均分'
                        }
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: '课程平均分对比图',
                        font: {
                            size: 16
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `平均分: ${context.raw.toFixed(2)}`;
                            }
                        }
                    }
                }
            }
        });

        chartInstances.push(chart);
    } else {
        analyticsContainer.innerHTML = '<div class="error-message">没有找到足够的课程或成绩数据</div>';
    }
} catch (error) {
    const analyticsContainer = document.getElementById('analytics-container');
    analyticsContainer.innerHTML = '<div class="error-message">课程对比分析加载失败，请重试</div>';
    console.error('Error loading course comparison:', error);
}

// 渲染学生趋势图表
async function renderStudentTrend() {
    try {
        const analyticsContainer = document.getElementById('analytics-container');

        // 获取学生和成绩数据
        const students = await apiRequest('students');
        const scores = await apiRequest('scores');
        const courses = await apiRequest('courses');
    

    if (students && students.length > 0 && scores && scores.length > 0 && courses && courses.length > 0) {
        // 构建学生选择下拉框
        analyticsContainer.innerHTML = `
            <h3>学生成绩趋势分析</h3>
            <div class="form-group">
                <label for="student-select-analysis">选择学生:</label>
                <select id="student-select-analysis" required></select>
            </div>
            <div class="chart-container">
                <canvas id="studentTrendChart"></canvas>
            </div>
            <div class="chart-info">
                <p>该图表显示了选定学生的成绩变化趋势。</p>
            </div>
        `;

        // 填充学生选择下拉框
        const studentSelect = document.getElementById('student-select-analysis');
        students.forEach(student => {
            const option = document.createElement('option');
            option.value = student.id;
            option.textContent = `${student.name} (${student.studentNumber})`;
            studentSelect.appendChild(option);
        });

        // 初始渲染第一个学生的趋势
        renderStudentChart(studentSelect.value);

        // 添加选择事件监听
        studentSelect.addEventListener('change', function() {
            renderStudentChart(this.value);
        });
    } else {
        analyticsContainer.innerHTML = '<div class="error-message">没有找到足够的学生、课程或成绩数据</div>';
    }
    } catch (error) {
        const analyticsContainer = document.getElementById('analytics-container');
        analyticsContainer.innerHTML = '<div class="error-message">学生趋势分析加载失败，请重试</div>';
        console.error('Error loading student trend analysis:', error);
    }
}
// 渲染特定学生的图表
function renderStudentChart(studentId) {
    // 清除现有图表
    chartInstances.forEach(chart => chart.destroy());
    chartInstances = [];

    // 获取相关数据
    const scores = window.scores || [];
    const courses = window.courses || [];

    // 筛选该学生的成绩
    const studentScores = scores.filter(score => score.studentId === parseInt(studentId));

    if (studentScores.length === 0) {
        document.getElementById('studentTrendChart').closest('.chart-container').innerHTML = '<div class="error-message">该学生没有成绩数据</div>';
        return;
    }

    // 按创建时间排序
    studentScores.sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));

    // 准备图表数据
    const labels = studentScores.map((score, index) => {
        const course = courses.find(c => c.id === score.courseId);
        return `${course ? course.courseName : `课程ID: ${score.courseId}`} (${index + 1})`;
    });

    const data = studentScores.map(score => score.scoreValue);

    // 创建图表
    const ctx = document.getElementById('studentTrendChart').getContext('2d');
    const chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '成绩',
                data: data,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgb(54, 162, 235)',
                borderWidth: 2,
                tension: 0.1,
                fill: false,
                pointBackgroundColor: 'rgb(54, 162, 235)',
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    title: {
                        display: true,
                        text: '成绩'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: '课程及成绩记录'
                    }
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: '学生成绩趋势图',
                    font: {
                        size: 16
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return `成绩: ${context.raw.toFixed(2)}`;
                        }
                    }
                }
            }
        }
    });

    chartInstances.push(chart);
}

// 渲染相关性分析图表

// 移除矩阵类型扩展，使用现有图表类型替代
// 我们将使用气泡图(bubble)代替自定义矩阵类型

// 计算相关系数
function calculateCorrelation(x, y) {
    if (x.length !== y.length) {
        throw new Error('两个数组的长度必须相同');
    }

    const n = x.length;
    let sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0, sumY2 = 0;

    for (let i = 0; i < n; i++) {
        sumX += x[i];
        sumY += y[i];
        sumXY += x[i] * y[i];
        sumX2 += x[i] * x[i];
        sumY2 += y[i] * y[i];
    }

    const numerator = n * sumXY - sumX * sumY;
    const denominator = Math.sqrt((n * sumX2 - sumX * sumX) * (n * sumY2 - sumY * sumY));

    if (denominator === 0) {
        return 0;
    }

    return numerator / denominator;
}

// 移除矩阵类型扩展，使用现有图表类型替代
// 我们将使用气泡图(bubble)代替自定义矩阵类型
async function renderCorrelationAnalysis() {
    const analyticsContainer = document.getElementById('analytics-container');
    analyticsContainer.innerHTML = `
        <h3>成绩相关性分析</h3>
        <div class="chart-container">
            <canvas id="correlationChart"></canvas>
        </div>
        <div class="chart-info">
            <p>该图表显示了不同课程之间的成绩相关性，帮助了解课程间的关联程度。</p>
        </div>
    `;

    try {
        // 获取课程和成绩数据
        const courses = await apiRequest('courses');
        const scores = await apiRequest('scores');

        if (courses && courses.length > 2 && scores && scores.length > 0) {
        // 为了简化，只选择前5门课程进行相关性分析
        const selectedCourses = courses.slice(0, 5);
        const courseIds = selectedCourses.map(course => course.id);
        const courseNames = selectedCourses.map(course => course.courseName);

        // 构建课程-学生成绩矩阵
        const studentScoresMap = new Map();

        scores.forEach(score => {
            if (courseIds.includes(score.courseId)) {
                if (!studentScoresMap.has(score.studentId)) {
                    studentScoresMap.set(score.studentId, new Map());
                }
                studentScoresMap.get(score.studentId).set(score.courseId, score.scoreValue);
            }
        });

        // 过滤出修完所有选定课程的学生
        const completeStudentScores = [];
        studentScoresMap.forEach((courseScores, studentId) => {
            if (courseScores.size === selectedCourses.length) {
                const scoresArray = [];
                courseIds.forEach(courseId => {
                    scoresArray.push(courseScores.get(courseId));
                });
                completeStudentScores.push(scoresArray);
            }
        });

        if (completeStudentScores.length < 2) {
            analyticsContainer.innerHTML = '<div class="error-message">没有足够的学生修完所选课程，无法进行相关性分析</div>';
            return;
        }

        // 计算相关性矩阵
        const correlationData = [];

        for (let i = 0; i < selectedCourses.length; i++) {
            for (let j = i + 1; j < selectedCourses.length; j++) {
                const correlation = calculateCorrelation(
                    completeStudentScores.map(scores => scores[i]),
                    completeStudentScores.map(scores => scores[j])
                );
                correlationData.push({
                    x: i,
                    y: j,
                    r: Math.abs(correlation) * 10 + 5, // 气泡大小
                    v: correlation
                });
            }
        }

        // 创建气泡图
        const ctx = document.getElementById('correlationChart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'bubble',
            data: {
                datasets: [{
                    label: '课程相关性',
                    data: correlationData,
                    backgroundColor: correlationData.map(item => {
                        const value = item.v;
                        if (value >= 0.7) return 'rgba(40, 167, 69, 0.7)'; // 绿色
                        if (value >= 0.3) return 'rgba(75, 192, 192, 0.7)'; // 青色
                        if (value >= -0.3) return 'rgba(255, 205, 86, 0.7)'; // 黄色
                        if (value >= -0.7) return 'rgba(255, 159, 64, 0.7)'; // 橙色
                        return 'rgba(255, 99, 132, 0.7)'; // 红色
                    }),
                    borderColor: correlationData.map(item => {
                        const value = item.v;
                        if (value >= 0.7) return 'rgb(40, 167, 69)';
                        if (value >= 0.3) return 'rgb(75, 192, 192)';
                        if (value >= -0.3) return 'rgb(255, 205, 86)';
                        if (value >= -0.7) return 'rgb(255, 159, 64)';
                        return 'rgb(255, 99, 132)';
                    }),
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        type: 'category',
                        labels: courseNames,
                        title: {
                            display: true,
                            text: '课程'
                        }
                    },
                    y: {
                        type: 'category',
                        labels: courseNames,
                        title: {
                            display: true,
                            text: '课程'
                        }
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: '课程成绩相关性气泡图',
                        font: {
                            size: 16
                        }
                    },
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            title: function(items) {
                                const item = items[0];
                                return `${courseNames[item.raw.x]} vs ${courseNames[item.raw.y]}`;
                            },
                            label: function(context) {
                                return `相关系数: ${context.raw.v.toFixed(2)}`;
                            }
                        }
                    }
                }
            }
        });

        chartInstances.push(chart);
    } else {
            analyticsContainer.innerHTML = '<div class="error-message">没有找到足够的课程或成绩数据进行相关性分析</div>';
        }
    } catch (error) {
        const analyticsContainer = document.getElementById('analytics-container');
        analyticsContainer.innerHTML = '<div class="error-message">相关性分析加载失败，请重试</div>';
        console.error('Error loading correlation analysis:', error);
    }
}
}
}


