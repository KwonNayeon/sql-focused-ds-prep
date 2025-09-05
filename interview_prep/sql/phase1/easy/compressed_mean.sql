-- ============================================================
-- [트러블슈팅 노트] Compressed Mean
-- Filename: compressed_mean.sql
-- 
-- [1] 목표:
--   - 주문당 평균 아이템 수 계산
--   - 소수점 첫째 자리까지 반올림하여 표시
--
-- [2] 문제 상황과 해결 과정:
--   1. 데이터 타입 문제:
--      - 정수 나눗셈으로 인한 부정확한 결과 발생
--      - NUMERIC 타입으로 명시적 형변환으로 해결
--      
--   2. 코드 가독성 개선:
--      - 복잡한 계산식을 ROUND 함수 내에서 깔끔하게 정리
--      - PostgreSQL의 :: 문법 활용하여 간결화
--
-- [3] 학습 포인트:
--   - PostgreSQL의 타입 변환과 연산:
--     * CAST(expression AS type) vs expression::type 문법 차이
--     * 정수 나눗셈과 실수 나눗셈의 결과 차이
--     * NUMERIC 타입 사용으로 정확한 소수점 계산 보장
--   - 압축된 데이터의 평균 계산:
--     * 빈도(order_occurrences)를 고려한 가중 평균 계산
--     * SUM(frequency * value) / SUM(frequency) 공식 활용
-- ============================================================

SELECT
   ROUND(
       SUM(order_occurrences * item_count)::NUMERIC / SUM(order_occurrences),
       1
   ) AS mean
FROM items_per_order;
