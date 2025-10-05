-- 插入测试消息数据
-- 假设用户表中已有 ID 为 1 和 2 的用户
-- 设置字符编码
SET NAMES utf8mb4;

-- 用户1(ID=1)发送给用户2(ID=2)的消息
INSERT INTO messages (sender_id, receiver_id, content, message_type, is_read, created_at) VALUES
(1, 2, 'hello teacher, I have a question about C pointers', 'text', 1, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(2, 1, 'Hello, please explain your question in detail', 'text', 1, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(1, 2, 'I got a segmentation fault when using pointers', 'text', 1, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(2, 1, 'It might be uninitialized pointer or out of bounds access', 'text', 0, DATE_SUB(NOW(), INTERVAL 30 MINUTE));

-- 用户3(ID=3)发送给用户1(ID=1)的消息
INSERT INTO messages (sender_id, receiver_id, content, message_type, is_read, created_at) VALUES
(3, 1, 'Teacher, I want to ask about calculus', 'text', 0, DATE_SUB(NOW(), INTERVAL 45 MINUTE)),
(1, 3, 'OK, please send me the problem', 'text', 1, DATE_SUB(NOW(), INTERVAL 40 MINUTE)),
(3, 1, 'This is a limit problem, I do not understand how to solve it', 'text', 0, DATE_SUB(NOW(), INTERVAL 35 MINUTE));

-- 用户4(ID=4)发送给用户2(ID=2)的消息
INSERT INTO messages (sender_id, receiver_id, content, message_type, is_read, created_at) VALUES
(4, 2, 'Teacher, when is the homework submission deadline?', 'text', 1, DATE_SUB(NOW(), INTERVAL 3 HOUR)),
(2, 4, 'The deadline is Friday 11:59 PM this week', 'text', 1, DATE_SUB(NOW(), INTERVAL 3 HOUR)),
(4, 2, 'OK, thank you teacher!', 'text', 1, DATE_SUB(NOW(), INTERVAL 2 HOUR));

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
