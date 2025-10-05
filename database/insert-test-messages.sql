-- 插入测试消息数据
-- 假设用户表中已有 ID 为 1 和 2 的用户

-- 用户1(ID=1)发送给用户2(ID=2)的消息
INSERT INTO messages (sender_id, receiver_id, content, message_type, is_read, created_at) VALUES
(1, 2, '老师好,我有一个关于C语言指针的问题', 'text', 1, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(2, 1, '你好,请详细说明你的问题', 'text', 1, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(1, 2, '我在使用指针时遇到了段错误,不知道是哪里出了问题', 'text', 1, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(2, 1, '可能是指针未初始化或越界访问,能把代码发给我看看吗?', 'text', 0, DATE_SUB(NOW(), INTERVAL 30 MINUTE));

-- 用户3(ID=3)发送给用户1(ID=1)的消息
INSERT INTO messages (sender_id, receiver_id, content, message_type, is_read, created_at) VALUES
(3, 1, '老师,我想请教一下高数题', 'text', 0, DATE_SUB(NOW(), INTERVAL 45 MINUTE)),
(1, 3, '好的,请把题目发给我', 'text', 1, DATE_SUB(NOW(), INTERVAL 40 MINUTE)),
(3, 1, '这是一道求极限的题目,我不太理解怎么求', 'text', 0, DATE_SUB(NOW(), INTERVAL 35 MINUTE));

-- 用户4(ID=4)发送给用户2(ID=2)的消息
INSERT INTO messages (sender_id, receiver_id, content, message_type, is_read, created_at) VALUES
(4, 2, '老师,作业提交截止日期是什么时候?', 'text', 1, DATE_SUB(NOW(), INTERVAL 3 HOUR)),
(2, 4, '截止日期是本周五晚上11点59分', 'text', 1, DATE_SUB(NOW(), INTERVAL 3 HOUR)),
(4, 2, '好的,谢谢老师!', 'text', 1, DATE_SUB(NOW(), INTERVAL 2 HOUR));

-- 查看插入的消息
SELECT 
    m.id,
    m.sender_id,
    m.receiver_id,
    m.content,
    m.is_read,
    m.created_at
FROM messages m
ORDER BY m.created_at DESC;
