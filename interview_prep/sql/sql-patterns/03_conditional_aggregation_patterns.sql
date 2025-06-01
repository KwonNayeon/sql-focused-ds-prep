-- Day 3: 조건부 집계 패턴
-- 여러 조건의 집계를 한 번에 계산하기

-- 패턴 1: CASE문 활용한 조건부 COUNT
SELECT 
    product_category,
    COUNT(*) as total_orders,
    COUNT(CASE WHEN status = 'completed' THEN 1 END) as completed_orders,
    COUNT(CASE WHEN status = 'cancelled' THEN 1 END) as cancelled_orders,
    COUNT(CASE WHEN amount > 100 THEN 1 END) as high_value_orders
FROM orders
GROUP BY product_category;

-- 패턴 2: SUM으로 조건부 카운팅 (더 간결)
SELECT 
    product_category,
    COUNT(*) as total_orders,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed_orders,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) as cancelled_orders,
    SUM(CASE WHEN amount > 100 THEN 1 ELSE 0 END) as high_value_orders
FROM orders
GROUP BY product_category;

-- 패턴 3: 조건부 SUM (실제 값 합계)
SELECT 
    user_id,
    SUM(amount) as total_spent,
    SUM(CASE WHEN order_date >= '2024-01-01' THEN amount ELSE 0 END) as spent_this_year,
    SUM(CASE WHEN product_category = 'electronics' THEN amount ELSE 0 END) as spent_on_electronics,
    AVG(CASE WHEN status = 'completed' THEN amount END) as avg_completed_order_value
FROM orders
GROUP BY user_id;

-- 패턴 4: 복잡한 비율 계산
SELECT 
    region,
    COUNT(*) as total_customers,
    ROUND(
        SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1
    ) as active_rate_percent,
    ROUND(
        AVG(CASE WHEN last_login_date >= CURRENT_DATE - INTERVAL '30 days' THEN 1.0 ELSE 0.0 END) * 100, 1
    ) as monthly_active_rate_percent
FROM customers
GROUP BY region;

-- 💡 핵심: CASE문으로 조건을 필터링하여 여러 지표를 한 번에 계산
-- 💡 COUNT vs SUM: COUNT는 NULL 무시, SUM은 0 포함