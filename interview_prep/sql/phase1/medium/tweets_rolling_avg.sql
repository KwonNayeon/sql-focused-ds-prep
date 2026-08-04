select
  user_id,
  tweet_date,
  round(avg(tweet_count) over (partition by user_id order by tweet_date rows between 2 preceding and current row),2) as rolling_avg_3d
from tweets
;

-- Window Frame 문법
-- PRECEDING    : 이전 행
-- FOLLOWING    : 이후 행
-- CURRENT ROW  : 현재 행
-- ROWS BETWEEN A AND B : A부터 B까지의 행을 계산 범위(Frame)로 지정

-- 자주 사용하는 예시

-- 현재 행 + 이전 2개 행 (최근 3개 행)
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

-- 현재 행 + 이전 4개 행 (최근 5개 행)
ROWS BETWEEN 4 PRECEDING AND CURRENT ROW

-- 현재 행부터 다음 2개 행
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING

-- 첫 번째 행부터 현재 행까지 (누적 계산)
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

-- 전체 행
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
