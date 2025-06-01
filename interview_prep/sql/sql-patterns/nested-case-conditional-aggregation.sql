-- 외부 CASE문 (첫 번째)
case when count(c.action) = 0 then 0
     else 
         -- 내부 계산 부분
         round(
             -- 내부 CASE문 (두 번째)
             sum(case when action = 'confirmed' then 1 else 0 end) * 1.0 / count(c.action), 2
         ) 
end as confirmation_rate
