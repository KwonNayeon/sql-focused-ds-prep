-- ============================================================
-- [트러블슈팅 노트] Pharmacy Analytics (Part 3)
-- Filename: pharmacy_analytics_3.sql
-- 
-- [1] 목표:
--   - 제조사별 총 매출액 계산
--   - 백만 단위로 반올림
--   - "$X million" 형식으로 출력
--   - 매출액 내림차순, 동일 매출시 제조사명 알파벳 순 정렬
--
-- [2] 문제 상황과 해결 과정:
--   1) 초기 문제점:
--      - ORDER BY sale로 정렬 시 문자열로 정렬되어
--        실제 숫자 크기와 다른 순서가 됨
--      - 예: '$1', '$10', '$2' 순으로 정렬됨
--   
--   2) 해결 방안:
--      - ORDER BY에 포맷팅 이전의 원본 숫자값 사용
--      - SUM(total_sales)로 정렬하여 실제 매출액 크기 순 정렬
--      - 같은 매출액의 경우 manufacturer로 2차 정렬
--
-- [3] 학습 포인트:
--   - 문자열 변환(CONCAT)과 정렬의 관계
--   - 출력용 포맷팅과 정렬용 값은 분리해서 사용
--   - ORDER BY절에서 SELECT 목록에 없는 표현식도 사용 가능
-- ============================================================

-- 1) 초기 시도: 포맷팅된 값으로 정렬 (잘못된 방법)
SELECT 
 manufacturer,
 CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY sale, manufacturer;

-- 2) 최종 쿼리: 원본 값으로 정렬
SELECT 
 manufacturer,
 CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;
