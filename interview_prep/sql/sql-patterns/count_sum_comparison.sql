-- 예시 테이블: orders
id | customer_id | amount
1  | 101         | 1000
2  | 102         | 500
3  | 101         | 300
4  | 103         | 200

-- COUNT: 행의 개수를 센다
SELECT COUNT(*) FROM orders;                    -- 결과: 4 (총 4개 주문)
SELECT COUNT(*) FROM orders WHERE amount > 400; -- 결과: 2 (400원 초과 주문이 2개)

-- SUM: 값들을 더한다  
SELECT SUM(amount) FROM orders;                 -- 결과: 2000 (1000+500+300+200)
SELECT SUM(amount) FROM orders WHERE amount > 400; -- 결과: 1500 (1000+500)

-- 고객별로 비교해보면 더 명확
SELECT 
   customer_id,
   COUNT(*) as 주문횟수,        -- 몇 번 주문했는지
   SUM(amount) as 총주문금액    -- 총 얼마나 주문했는지
FROM orders 
GROUP BY customer_id;

-- 결과:
-- customer_id | 주문횟수 | 총주문금액
-- 101         | 2       | 1300      (2번 주문, 1000+300)
-- 102         | 1       | 500       (1번 주문, 500)  
-- 103         | 1       | 200       (1번 주문, 200)
