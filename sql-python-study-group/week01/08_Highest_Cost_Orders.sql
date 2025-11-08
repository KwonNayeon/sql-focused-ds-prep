-- 1. 고객별 일일 합계 구하기 (2019-02-01 ~ 2019-05-01)
-- 2. 각 날짜별로 합계 기준 순위 매기기 (동점 포함)
-- 3. 날짜별 1위만 추출
with daily_totals as (
    select
        c.first_name,
        sum(o.total_order_cost) as daily_total,
        order_date
    from customers c
    left join orders o on c.id = o.cust_id
    where order_date between '2019-02-01' and '2019-05-01'
    group by c.first_name, o.order_date
),
ranked as (
    select
        first_name,
        order_date,
        daily_total,
        rank () over (partition by order_date order by daily_total desc) as rn
    from daily_totals
)
select
    first_name,
    order_date,
    daily_total as max_cost
from ranked
where rn = 1
;

-- Review Notes:
-- 2025-11-07: partition by order_date 해야 날짜별 최고액을 구할 수 있음, 꼭 다시 풀어보기
-- 2025-11-08: CTE 이름 더 명확하게 쓰는 연습하기
