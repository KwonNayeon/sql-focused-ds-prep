SELECT
  round(count(b.email_id)*1.0/count(distinct a.email_id),2) as activation_rate
FROM emails a
left join texts b
on a.email_id = b.email_id
and b.signup_action = 'Confirmed'
;

-- Review Notes:
-- 2026-08-05: 복습, 두 테이블을 연결할 때 left join을 사용해야 함
