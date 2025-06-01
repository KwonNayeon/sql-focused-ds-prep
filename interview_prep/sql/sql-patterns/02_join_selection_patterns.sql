-- Day 2: JOIN 패턴 선택하기
-- 핵심 질문: "모든 왼쪽 테이블 데이터가 필요한가?"

-- 상황 1: 모든 사용자의 주문 현황 (주문 안한 사용자도 포함)
SELECT 
    u.user_id,
    u.name,
    COUNT(o.order_id) as order_count,
    COALESCE(SUM(o.amount), 0) as total_spent
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id  -- LEFT JOIN 필수!
GROUP BY u.user_id, u.name;

-- 상황 2: 실제 주문한 사용자만 분석
SELECT 
    u.user_id,
    u.name,
    COUNT(o.order_id) as order_count,
    SUM(o.amount) as total_spent
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id  -- INNER JOIN 적절
GROUP BY u.user_id, u.name;

-- 상황 3: 확인율 계산 (가입자 모두 포함)
SELECT 
    s.user_id,
    CASE 
        WHEN COUNT(c.action) = 0 THEN 0
        ELSE ROUND(
            SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 / 
            COUNT(c.action), 2
        )
    END as confirmation_rate
FROM signups s
LEFT JOIN confirmations c ON s.user_id = c.user_id  -- 가입만 하고 확인 안한 사람도 포함
GROUP BY s.user_id;

-- 💡 판단 기준:
-- LEFT JOIN: 왼쪽 테이블의 모든 레코드 보존 필요
-- INNER JOIN: 매칭되는 데이터만 필요
-- 💡 집계할 때는 특히 JOIN 타입이 결과를 크게 바꿈!