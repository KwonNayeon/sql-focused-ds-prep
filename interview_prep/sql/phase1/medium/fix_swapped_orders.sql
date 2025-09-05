-- ============================================================
-- [트러블슈팅 노트] 잘못된 주문-음식 매칭 수정
-- Filename: fix_swapped_orders.sql
-- 
-- [1] 목표:
--   - 시스템 오류로 인해 서로 맞바꿔진(swap된) 홀수-짝수 주문 쌍을 원상 복구
--   - 마지막 주문번호가 홀수인 경우는 예외 처리하여 유지
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 상황 분석:
--      - 인접한 홀수-짝수 주문 쌍이 서로 swap된 상태
--      - 예: (1번↔2번), (3번↔4번), (5번↔6번) 주문이 서로 바뀜
--      
--   2. 해결 방안:
--      - 홀수-짝수 쌍을 찾아 원래 순서로 복구
--      - LEAD/LAG 윈도우 함수로 swap된 데이터 교환
--      - CASE WHEN으로 마지막 홀수 주문 예외 처리
--
-- [3] 학습 포인트:
--   - 윈도우 함수 활용:
--     * LEAD: 다음 행의 데이터 참조
--     * LAG: 이전 행의 데이터 참조
--   - 조건부 처리:
--     * CASE WHEN을 활용한 홀수/짝수 쌍 처리
--     * 마지막 레코드 특별 처리
--   - 주문 번호 처리:
--     * ORDER BY로 순서 보장
--     * MOD 연산자(%)로 홀수/짝수 판별
-- ============================================================
SELECT 
   order_id as corrected_order_id,
   CASE
       -- 마지막 주문번호가 홀수인 경우 그대로 유지
       WHEN order_id = (SELECT MAX(order_id) FROM orders) 
           AND order_id % 2 = 1 
       THEN item
       
       -- 홀수 주문번호는 다음 행의 아이템과 교환
       WHEN order_id % 2 = 1 
       THEN LEAD(item) OVER (ORDER BY order_id)
       
       -- 짝수 주문번호는 이전 행의 아이템과 교환
       WHEN order_id % 2 = 0 
       THEN LAG(item) OVER (ORDER BY order_id)
   END AS item
FROM orders
ORDER BY order_id
;
