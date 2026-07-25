-- Find the percentage of shipable orders
select
    (count(case when c.address is not null then 1 end) * 1.0 / count(*))*100 as shipable_orders
from orders o
join customers c
on o.cust_id = c.id
;
-- Review Notes:
-- 2026-07-25: 복습, 비율 계산 시 나눗셈 전에 한쪽을 실수형으로 만들어 주는 것 잊지 말기
