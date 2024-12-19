-- ============================================================
-- [트러블슈팅 노트] Histogram of Tweets
-- Filename: histogram_of_tweets.sql
-- 
-- [1] 목표:
--   - 2022년 사용자별 트윗 수를 기준으로 히스토그램 생성
--   - 각 트윗 수(bucket)별로 해당하는 사용자 수를 계산
--
-- [2] 문제 해결 과정:
--   1. 연도 데이터 추출:
--      - EXTRACT(YEAR FROM tweet_date)로 각 트윗의 연도 추출
--      - yearly_tweets CTE에서 원본 데이터와 연도 정보 준비
--   
--   2. 사용자별 트윗 수 계산:
--      - tweet_count CTE에서 user_id별로 GROUP BY하여 트윗 수 집계
--      - WHERE year = 2022로 2022년 데이터만 필터링
--   
--   3. 히스토그램 생성:
--      - 최종 SELECT에서 트윗 수(cnt)로 다시 GROUP BY
--      - 각 트윗 수에 해당하는 사용자 수를 COUNT로 계산
--
-- [3] 학습 포인트:
--   - EXTRACT 함수: PostgreSQL에서 날짜에서 연도 추출
--   - 다중 GROUP BY: 서로 다른 수준에서 두 번의 GROUP BY 사용
--   - CTE 활용: 복잡한 집계 작업을 논리적 단계로 분리
--   - 히스토그램: 특정 값의 빈도를 계산하는 통계적 방법
-- ============================================================

WITH yearly_tweets AS (
   SELECT 
       *, 
       EXTRACT(YEAR FROM tweet_date) AS year
   FROM tweets
),
tweet_count AS (
   SELECT
       user_id,
       COUNT(*) AS cnt
   FROM yearly_tweets
   WHERE year = 2022
   GROUP BY user_id
)
SELECT 
   cnt AS tweet_bucket,
   COUNT(*) AS users_num
FROM tweet_count
GROUP BY cnt
ORDER BY cnt;
