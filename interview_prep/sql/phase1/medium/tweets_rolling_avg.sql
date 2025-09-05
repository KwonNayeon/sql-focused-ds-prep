-- ============================================================
-- [트러블슈팅 노트] Tweets' Rolling Averages
-- Filename: tweets_rolling_avg.sql
-- 
-- [1] 목표:
--   - 각 사용자별 트윗 수의 3일 이동 평균 계산
--   - 사용자 ID, 날짜, 이동 평균값(소수점 2자리) 조회
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - ORDER BY절에 user_id와 tweet_date를 함께 사용
--      - 사용자 구분 없이 전체 데이터에 대해 이동 평균 계산
--      - 결과적으로 서로 다른 사용자의 데이터가 섞여서 계산됨
--      
--   2. PARTITION BY 적용:
--      - 사용자별 독립적인 이동 평균 계산을 위해 PARTITION BY 추가
--      - ORDER BY절에서 user_id 제거하고 tweet_date만 사용
--      - 각 사용자별로 날짜 순서대로 3일 이동 평균 계산
--
-- [3] 학습 포인트:
--   - 윈도우 함수의 PARTITION BY 활용:
--     * 그룹별 독립적인 계산 수행 방법
--     * 이동 평균 계산 시 데이터 분리의 중요성
--   - 이동 평균 계산 시 주의사항:
--     * ORDER BY절에는 시간 순서만 고려
--     * ROWS BETWEEN 구문의 정확한 범위 설정
--     * ROUND 함수를 통한 소수점 자릿수 제어
-- ============================================================

SELECT
  user_id,
  tweet_date,
  round(avg(tweet_count) over (
      partition by user_id
      order by tweet_date
      rows between 2 PRECEDING and current ROW
  ), 2) as rolling_avg_3d
from tweets
