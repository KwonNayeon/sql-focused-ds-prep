-- Day 7: CTE (Common Table Expression) 패턴
-- 복잡한 쿼리를 단계별로 나누어 가독성 향상

-- 패턴 1: 단계별 데이터 가공
WITH user_stats AS (
    -- 1단계: 사용자별 기본 통계
    SELECT 
        user_id,
        COUNT(*) as total_orders,
        SUM(amount) as total_spent,
        MIN(order_date) as first_order_date,
        MAX(order_date) as last_order_date
    FROM orders
    GROUP BY user_id
),
user_segments AS (
    -- 2단계: 사용자 세그먼트 분류
    SELECT 
        user_id,
        total_orders,
        total_spent,
        CASE 
            WHEN total_spent >= 1000 THEN 'VIP'
            WHEN total_spent >= 500 THEN 'Premium'
            WHEN total_spent >= 100 THEN 'Regular'
            ELSE 'New'
        END as user_segment,
        CASE 
            WHEN CURRENT_DATE - last_order_date <= 30 THEN 'Active'
            WHEN CURRENT_DATE - last_order_date <= 90 THEN 'At Risk'
            ELSE 'Inactive'
        END as activity_status
    FROM user_stats
)
-- 3단계: 최종 분석
SELECT 
    user_segment,
    activity_status,
    COUNT(*) as user_count,
    AVG(total_spent) as avg_spent,
    AVG(total_orders) as avg_orders
FROM user_segments
GROUP BY user_segment, activity_status
ORDER BY user_segment, activity_status;

-- 패턴 2: 복잡한 필터링과 순위
WITH product_performance AS (
    SELECT 
        product_id,
        product_name,
        SUM(quantity) as total_sold,
        SUM(amount) as total_revenue,
        COUNT(DISTINCT order_id) as order_count
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    WHERE order_date >= '2024-01-01'
    GROUP BY product_id, product_name
),
ranked_products AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) as revenue_rank,
        ROW_NUMBER() OVER (ORDER BY total_sold DESC) as quantity_rank,
        ROUND(total_revenue * 100.0 / SUM(total_revenue) OVER (), 2) as revenue_share_percent
    FROM product_performance
)
SELECT *
FROM ranked_products
WHERE revenue_rank <= 10 OR quantity_rank <= 10;  -- 매출 또는 판매량 TOP 10

-- 패턴 3: 재귀 CTE (조직도, 카테고리 트리 등)
WITH RECURSIVE category_hierarchy AS (
    -- 1단계: 최상위 카테고리
    SELECT 
        category_id,
        category_name,
        parent_category_id,
        0 as level,
        category_name as full_path
    FROM categories
    WHERE parent_category_id IS NULL
    
    UNION ALL
    
    -- 2단계: 하위 카테고리들을 재귀적으로 추가
    SELECT 
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ch.level + 1,
        ch.full_path + ' > ' + c.category_name
    FROM categories c
    JOIN category_hierarchy ch ON c.parent_category_id = ch.category_id
    WHERE ch.level < 5  -- 무한 루프 방지
)
SELECT 
    REPEAT('  ', level) + category_name as indented_name,  -- 들여쓰기로 계층 표현
    level,
    full_path
FROM category_hierarchy
ORDER BY full_path;

-- 패턴 4: 여러 CTE 조합
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) as month,
        SUM(amount) as monthly_total
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
sales_with_growth AS (
    SELECT 
        month,
        monthly_total,
        LAG(monthly_total) OVER (ORDER BY month) as prev_month,
        monthly_total - LAG(monthly_total) OVER (ORDER BY month) as growth_amount
    FROM monthly_sales
),
final_analysis AS (
    SELECT 
        month,
        monthly_total,
        growth_amount,
        CASE 
            WHEN growth_amount > 0 THEN 'Growth'
            WHEN growth_amount < 0 THEN 'Decline'
            ELSE 'Stable'
        END as trend
    FROM sales_with_growth
    WHERE prev_month IS NOT NULL
)
SELECT * FROM final_analysis ORDER BY month;

-- 핵심: 복잡한 로직을 단계별로 나누어 이해하기 쉽게
-- CTE는 쿼리 내에서만 유효 (VIEW와 다름)
-- 재귀 CTE는 계층형 데이터 처리에 강력함