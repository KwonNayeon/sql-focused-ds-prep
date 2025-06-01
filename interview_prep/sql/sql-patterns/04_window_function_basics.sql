-- Day 4: 윈도우 함수 기본 패턴
-- 행별로 집계값을 계산하면서 원본 행은 유지

-- 패턴 1: 순위 매기기
SELECT 
    user_id,
    order_date,
    amount,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY order_date DESC) as order_sequence,
    RANK() OVER (ORDER BY amount DESC) as amount_rank,
    DENSE_RANK() OVER (ORDER BY amount DESC) as dense_amount_rank
FROM orders;

-- 패턴 2: 누적값과 이동평균
SELECT 
    user_id,
    order_date,
    amount,
    SUM(amount) OVER (PARTITION BY user_id ORDER BY order_date) as running_total,
    AVG(amount) OVER (PARTITION BY user_id ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_3,
    COUNT(*) OVER (PARTITION BY user_id ORDER BY order_date) as order_count_so_far
FROM orders
ORDER BY user_id, order_date;

-- 패턴 3: 이전/다음 값 참조
SELECT 
    user_id,
    order_date,
    amount,
    LAG(amount) OVER (PARTITION BY user_id ORDER BY order_date) as prev_order_amount,
    LEAD(order_date) OVER (PARTITION BY user_id ORDER BY order_date) as next_order_date,
    amount - LAG(amount) OVER (PARTITION BY user_id ORDER BY order_date) as amount_change
FROM orders;

-- 패턴 4: 그룹 내 비율 계산
SELECT 
    product_category,
    product_name,
    sales_amount,
    ROUND(
        sales_amount * 100.0 / SUM(sales_amount) OVER (PARTITION BY product_category), 2
    ) as category_share_percent,
    ROUND(
        sales_amount * 100.0 / SUM(sales_amount) OVER (), 2
    ) as total_share_percent
FROM product_sales;

-- 💡 핵심: PARTITION BY로 그룹 나누고, ORDER BY로 정렬 기준 설정
-- 💡 ROWS/RANGE로 윈도우 범위 조정 가능
-- 💡 일반 집계와 달리 원본 행 수 유지!