-- Day 1: 0으로 나누기 방지 패턴
-- 언제 사용: 비율, 평균, 퍼센트 계산할 때

-- 패턴 1: CASE문으로 방지
SELECT 
    user_id,
    CASE 
        WHEN total_attempts = 0 THEN 0
        ELSE ROUND(successful_attempts * 1.0 / total_attempts, 2)
    END as success_rate
FROM user_stats;

-- 패턴 2: NULLIF + COALESCE 조합 (더 간결)
SELECT 
    user_id,
    COALESCE(successful_attempts * 1.0 / NULLIF(total_attempts, 0), 0) as success_rate
FROM user_stats;

-- 패턴 3: 복잡한 조건부 집계에서
SELECT 
    category,
    CASE 
        WHEN COUNT(CASE WHEN status = 'completed' THEN 1 END) = 0 THEN 0
        ELSE ROUND(
            SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) * 1.0 / 
            COUNT(CASE WHEN status = 'completed' THEN 1 END), 2
        )
    END as completion_success_rate
FROM tasks
GROUP BY category;

-- 핵심: 분모가 0이 될 가능성이 있으면 반드시 체크!
-- NULLIF(값, 0)은 값이 0이면 NULL 반환, 아니면 원래 값 반환