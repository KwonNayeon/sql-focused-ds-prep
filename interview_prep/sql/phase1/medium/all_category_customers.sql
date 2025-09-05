-- ============================================================
-- [트러블슈팅 노트] 전체 카테고리 구매 고객 추출 쿼리
-- Filename: all_category_customers.sql
-- 
-- [1] 문제 상황과 해결 과정:
--   1. COUNT 함수 사용 이슈:
--      - 단순 COUNT로는 카테고리 중복 집계되는 문제 발생
--      - COUNT(DISTINCT)로 수정하여 카테고리별 중복 제거
--      
--   2. 전체 카테고리 기준값 설정:
--      - 하드코딩(3)으로 처리했다가 유연성 부족 문제 발생
--      - 서브쿼리로 전체 카테고리 수 동적 조회하도록 수정
--
--   3. 쿼리 구조화:
--      - 임시 테이블 사용으로 가독성 향상
--      - WITH 대신 인라인 뷰 사용하여 동일 결과 도출
--
-- [2] 핵심 학습 포인트:
--   1. COUNT(DISTINCT) 활용
--      - 중복 제거가 필요한 집계시 DISTINCT 필수
--
--   2. 동적 기준값 처리
--      - 하드코딩 대신 서브쿼리 활용이 유지보수에 유리
--
--   3. 쿼리 구조화 방법
--      - WITH절과 인라인 뷰는 동일 결과 도출 가능
-- ============================================================

SELECT customer_id
FROM (
 SELECT
   c.customer_id,
   count(distinct p.product_category) as product_count
 FROM customer_contracts c 
 INNER JOIN products p ON c.product_id = p.product_id
 GROUP BY c.customer_id
) t
WHERE product_count = (SELECT COUNT(DISTINCT product_category) FROM products)
;
