-- Day 6: 날짜 처리 패턴
-- 날짜 계산과 범위 처리의 필수 패턴들

-- 패턴 1: 날짜 범위 필터링
SELECT 
    user_id,
    order_date,
    amount
FROM orders
WHERE order_date >= '2024-01-01' 
  AND order_date < '2024-02-01'  -- 2024년 1월 전체
  -- 또는
  AND order_date BETWEEN '2024-01-01' AND '2024-01-31'
  -- 최근 30일
  AND order_date >= CURRENT_DATE - INTERVAL '30 days';

-- 패턴 2: 날짜 그룹핑과 집계
SELECT 
    DATE_TRUNC('month', order_date) as month,        -- PostgreSQL
    -- DATE_FORMAT(order_date, '%Y-%m') as month,    -- MySQL
    -- FORMAT(order_date, 'yyyy-MM') as month,       -- SQL Server
    COUNT(*) as order_count,
    SUM(amount) as monthly_sales
FROM orders
WHERE order_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 패턴 3: 요일별, 시간대별 분석
SELECT 
    EXTRACT(DOW FROM order_date) as day_of_week,  -- 0=일요일, PostgreSQL
    -- DAYOFWEEK(order_date) as day_of_week,      -- 1=일요일, MySQL
    EXTRACT(HOUR FROM order_date) as hour_of_day,
    COUNT(*) as order_count,
    AVG(amount) as avg_order_value
FROM orders
GROUP BY EXTRACT(DOW FROM order_date), EXTRACT(HOUR FROM order_date)
ORDER BY day_of_week, hour_of_day;

-- 패턴 4: 날짜 차이 계산
SELECT 
    user_id,
    first_order_date,
    last_order_date,
    last_order_date - first_order_date as days_between_first_last,
    CURRENT_DATE - last_order_date as days_since_last_order,
    CASE 
        WHEN CURRENT_DATE - last_order_date <= 30 THEN 'Active'
        WHEN CURRENT_DATE - last_order_date <= 90 THEN 'At Risk'
        ELSE 'Inactive'
    END as customer_status
FROM (
    SELECT 
        user_id,
        MIN(order_date) as first_order_date,
        MAX(order_date) as last_order_date
    FROM orders
    GROUP BY user_id
) user_order_summary;

-- 패턴 5: 월별 증감률 계산
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) as month,
        SUM(amount) as monthly_total
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    month,
    monthly_total,
    LAG(monthly_total) OVER (ORDER BY month) as prev_month_total,
    ROUND(
        (monthly_total - LAG(monthly_total) OVER (ORDER BY month)) * 100.0 / 
        LAG(monthly_total) OVER (ORDER BY month), 2
    ) as growth_rate_percent
FROM monthly_sales
ORDER BY month;

-- 핵심: 날짜 함수는 DB마다 문법이 다름
-- 시간대 처리 주의 (UTC vs Local)
-- 날짜 범위는 >= 시작일 AND < 다음날 패턴 추천