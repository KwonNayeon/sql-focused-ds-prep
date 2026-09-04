-- 내 접근 방법
with filter as (
  select
    user_id,
    extract(year from filing_date) as year,
    lag(extract(year from filing_date)) over (partition by user_id order by extract(year from filing_date)) as previous_year
  from filed_taxes
  where product like 'TurboTax%'
)
select
  distinct user_id
from filter
where (year - previous_year) is null or (year - previous_year) = 1
group by user_id
having count(user_id) >= 3
;
-- 틀린 이유: where로 걸러진 행들이 서로 다른 연속 구간에서 왔을 때도 count에 합산되기 때문(구간이 끊겨도 포함됨)

-- 정답
with filtered as (
  select
    user_id,
    extract(year from filing_date) as yr
  from filed_taxes
  where product like 'TurboTax%'
),
ranked as (
  select
    user_id,
    yr,
    yr - row_number() over (partition by user_id order by yr) as grp
  from filtered
),
grouped as (
  select
    user_id,
    grp,
    count(*) as consecutive_years
  from ranked
  group by user_id, grp
)
select distinct user_id
from grouped
where consecutive_years >= 3
order by user_id asc
;

-- Review Notes:
-- 2026-09-03: 내일 이 문제 복습하기
-- 2026-09-04: cte 두 개로도 문제 풀 수 있음, 연속적인 값일 때 yr - rn의 값이 같다는 것 기억하기
