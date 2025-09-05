-- ============================================================
-- [트러블슈팅 노트] Teams Power Users
-- Filename: teams_power_users.sql
-- 
-- [1] 목표:
--   - 2022년 8월 Teams 메시지를 가장 많이 보낸 상위 2명의 사용자 찾기
--   - sender_id와 메시지 수 반환
--   - 메시지 수 기준 내림차순 정렬
--
-- [2] 문제 해결 과정:
--   1. GROUP BY 이슈:
--      - 초기: message_id를 집계함수 없이 SELECT
--      - 해결: COUNT(message_id)로 올바른 집계 구현
--   
--   2. 날짜 필터링:
--      - 연도만 필터링하던 쿼리를 연도+월 필터링으로 개선
--      - GROUP BY절에도 월 정보 추가하여 정확한 그룹핑
--
--   3. 최종 쿼리 정리:
--      - WITH 절로 임시 결과셋 생성
--      - 필요한 컬럼만 SELECT하여 최종 결과 도출
--      - message_count 기준 내림차순 정렬 후 상위 2개 추출
--
-- [3] 학습 포인트:
--   - GROUP BY: 집계함수와 함께 사용해야 함
--   - EXTRACT: 날짜에서 연도/월 추출 (SQLite는 strftime 사용)
--   - ORDER BY + LIMIT: 상위 N개 레코드 추출
--   - CTE(WITH 구문): 복잡한 쿼리의 가독성 향상
-- ============================================================

WITH data1 AS (
 SELECT
   sender_id,
   COUNT(message_id) AS message_count,
   EXTRACT(YEAR FROM sent_date) AS year,
   EXTRACT(MONTH FROM sent_date) AS month
 FROM messages
 GROUP BY
   sender_id,
   EXTRACT(YEAR FROM sent_date),
   EXTRACT(MONTH FROM sent_date)
)
SELECT sender_id, message_count
FROM data1
WHERE year = 2022 AND month = 8
ORDER BY message_count DESC
LIMIT 2;
