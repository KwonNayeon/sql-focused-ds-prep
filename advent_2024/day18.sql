-- ============================================================
-- [트러블슈팅 노트]
-- 
-- [1] 목표:
--   - 펭귄 데이터에서 각 종(species)에 대해
--     날개 길이(flipper_length_mm)와 몸무게(body_mass_g)의 
--     피어슨 상관계수를 계산.
--
-- [2] 문제 상황과 해결 과정:
--   1. 데이터 정리:
--      - null 값이 있는 데이터를 제외하기 위해 WHERE 조건 사용.
--      - WITH 문(data CTE)으로 필요한 컬럼(species, x, y)만 필터링.
--   
--   2. 상관계수 계산 공식 적용:
--      - 상관계수 공식을 SQL로 변환:
--        corr = (n * sum(x*y) - sum(x)*sum(y)) / 
--               sqrt((n*sum(x^2) - sum(x)^2) * (n*sum(y^2) - sum(y)^2))
--      - 이를 계산하기 위해 CTE(formula)에서 각 종(species)에 대해 
--        n, sum_x, sum_y 등 공식을 구성하는 값을 GROUP BY로 집계.
--   
--   3. 상관계수 값의 유효성 처리:
--      - 분모(표준편차)가 0인 경우 NULL 반환 처리.
--      - CASE 문으로 분모가 0인 경우 null을 반환하도록 설정.
--
-- [3] 학습 포인트:
--   - null 처리: 데이터를 정리할 때 WHERE 절을 통해 null 값을 필터링.
--   - 상관계수 공식 변환: 공식을 SQL에서 구현 가능한 형태로 변환.
--   - CASE 문 활용: 조건부 로직으로 edge case 처리.
--   - GROUP BY와 CTE 활용: 논리적 단계로 쿼리 분리 및 가독성 향상.
-- ============================================================

with data as(
  select
    species,
    flipper_length_mm as x,
    body_mass_g as y
  from penguins
  where x is not null and y is not null
),
formula as (
  select
    species,
    count(*) as n,
    sum(x*Y) as sum_xy,
    sum(x) as sum_x,
    sum(y) as sum_y,
    sum(x*x) as sum_x2,
    sum(y*y) as sum_y2
  from data
  group by species
),
correlation as (
  select
    species,
    case
      when (n*sum_x2 - sum_x*sum_x)*(n*sum_y2 - sum_y*sum_y) = 0 then null
      else (n*sum_xy - sum_x*sum_y) / (sqrt((n*sum_x2 - sum_x*sum_x)*(n*sum_y2 - sum_y*sum_y)))
    end as corr
  from formula
)
select species, round(corr, 3) as corr
from correlation
;
