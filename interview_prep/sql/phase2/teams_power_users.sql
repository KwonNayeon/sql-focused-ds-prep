-- 복습: 아래의 개선된 쿼리 훑어보기
SELECT
  sender_id,
  count(*) as message_sent
from messages
where extract(year from sent_date) = 2022
  and extract(month from sent_date) = 08
group by sender_id
order by message_sent desc
limit 2
;

-- 또 다른 방법
SELECT sender_id, COUNT(*) as message_sent 
FROM messages 
WHERE sent_date >= '2022-08-01' AND sent_date < '2022-09-01'
GROUP BY sender_id 
ORDER BY message_sent DESC 
LIMIT 2;