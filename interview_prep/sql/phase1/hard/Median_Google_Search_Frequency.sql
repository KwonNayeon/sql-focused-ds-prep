-- 풀이 1
with searches_expanded as (
  -- 집계 테이블을 행 단위로 펼침
  select searches
  from search_frequency
  group by searches, GENERATE_SERIES(1, num_users)
)
select
  -- Median을 구하는 공식
  round(percentile_cont(0.5) within group (order by searches)::decimal, 1) as median
from searches_expanded
;

-- 풀이 2(쿼리의 의도가 더 명확함)
with searches_expanded as (
  select sf.searches
  from search_frequency sf
  -- lateral을 붙이면 오른쪽에 있는 서브쿼리/함수가 왼쪽 테이블의 각 행을 하나씩 참조하면서 실행됨
  cross join lateral generate_series(1, sf.num_users) as g(i)
)
select
  round(
    (percentile_cont(0.5) within group (order by searches))::decimal,
    1
  ) as median
from searches_expanded
;

-- Review Notes:
-- 2026-08-31: 어려운 문제, 나중에 복습하기
-- 2026-09-01: 복습 완료
