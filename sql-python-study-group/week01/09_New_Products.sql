with data as (
    select
        company_name,
        year,
        count(*) as cnt
    from car_launches
    group by company_name, year
)
select
    company_name,
    sum(case when year = 2020 then cnt else 0 end) - 
    sum(case when year = 2019 then cnt else 0 end) as net_products
from data
group by company_name
;

-- Review Notes:
-- 2025-11-07: 다시 풀어보기
