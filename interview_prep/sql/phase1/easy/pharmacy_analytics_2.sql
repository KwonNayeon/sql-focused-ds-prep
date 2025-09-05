-- ============================================================
-- [트러블슈팅 노트] Pharmacy Analytics (Part 2)
-- Filename: pharmacy_analytics_2.sql
-- 
-- [1] 목표:
--   - 손실이 발생한 제조사별 통계 추출
--   - 필요 정보: 제조사명, 손실 발생 약품 수, 총 손실액(절대값)
--   - 가장 큰 손실순으로 정렬
--
-- [2] 문제 상황과 해결 과정:
--   1) 초기 쿼리 문제점:
--      - GROUP BY 누락으로 제조사별 집계 불가
--      - COUNT(*) 누락으로 약품 수 계산 불가
--      - 단순 ABS가 아닌 SUM(ABS())로 수정 필요
--   
--   2) 해결 방안:
--      - WITH절에서 손실 발생 데이터 먼저 필터링
--      - GROUP BY로 제조사별 집계
--      - COUNT(*)로 약품 수 계산
--      - SUM(ABS(total_loss))로 총 손실액 계산
--
-- [3] 학습 포인트:
--   - GROUP BY의 필요성: 테이블은 기본적으로 row 단위 데이터
--   - 집계함수(COUNT, SUM)와 GROUP BY의 관계
--   - ABS vs SUM(ABS): 절대값 처리 시점의 중요성
-- ============================================================

-- 1) 초기 시도: 기본적인 손실액 계산
WITH data AS (
 SELECT
   manufacturer,
   total_sales - cogs as total_loss
 FROM pharmacy_sales
 WHERE total_sales - cogs < 0
 ORDER BY total_loss ASC
)
SELECT manufacturer, 
      ABS(total_loss)
FROM data;

-- 2) 최종 쿼리: 제조사별 집계 추가
WITH data AS (
 SELECT
   manufacturer,
   total_sales - cogs as total_loss
 FROM pharmacy_sales
 WHERE total_sales - cogs < 0
)
SELECT 
 manufacturer,
 COUNT(*) as drug_count,
 SUM(ABS(total_loss)) as total_loss
FROM data
GROUP BY manufacturer
ORDER BY total_loss DESC;
