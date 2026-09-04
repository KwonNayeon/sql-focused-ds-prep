select
  sender_id,
  count(message_id) as message_count
from messages
where extract(year from sent_date) = '2022' and extract(month from sent_date) = '08'
group by sender_id
order by count(message_id) desc
limit 2
;
