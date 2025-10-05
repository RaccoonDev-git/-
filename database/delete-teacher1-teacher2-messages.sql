-- 删除teacher1(ID=1)和teacher2(ID=2)之间的消息
-- 设置字符编码
SET NAMES utf8mb4;

-- 删除用户1和用户2之间的所有消息
DELETE FROM messages 
WHERE (sender_id = 1 AND receiver_id = 2) 
   OR (sender_id = 2 AND receiver_id = 1);

-- 查看剩余的消息
SELECT 
    m.id,
    m.sender_id,
    m.receiver_id,
    m.content,
    m.is_read,
    m.created_at
FROM messages m
ORDER BY m.created_at DESC;

-- 显示删除结果
SELECT '已删除teacher1和teacher2之间的所有消息' AS status;
