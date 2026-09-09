-- 풀이 1
WITH email_text_joined AS (
   SELECT *
   FROM emails A
   LEFT JOIN texts B
       ON A.email_id = B.email_id
)
SELECT 
   user_id
FROM email_text_joined
WHERE DATE_PART('day', action_date - signup_date) = 1;

-- 풀이 2
SELECT
  a.user_id
FROM emails a
join texts b
on a.email_id = b.email_id
where b.signup_action = 'Confirmed'
  and b.action_date::date - a.signup_date::date = 1
;
