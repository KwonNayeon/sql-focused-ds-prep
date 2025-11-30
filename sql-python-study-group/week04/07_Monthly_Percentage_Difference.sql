-- Monthly Percentage Difference
/*
LAG/LEAD 관련:
- 이미 GROUP BY로 집계된 데이터는 각 그룹당 행이 1개씩만 존재
- PARTITION BY로 다시 나누면 각 파티션에 행이 1개뿐 → LAG/LEAD 의미 없음
- 시계열 데이터는 ORDER BY로 이전/다음 값 가져오기
*/
with month as (
    select
        date_trunc('month', created_at) as year_month,
        sum(value) as monthly_revenue
    from sf_transactions
    group by date_trunc('month', created_at)
),
lag as (
    select
        year_month,
        monthly_revenue,
        lag(monthly_revenue) over (order by year_month) as previous_revenue
    from month
)
select
    year_month,
    round(((monthly_revenue - previous_revenue)*1.0/previous_revenue*1.0)*100, 2) as revenue_diff_pct
from lag
;
-- Review Notes:
-- 2025-11-30: 복습하자
