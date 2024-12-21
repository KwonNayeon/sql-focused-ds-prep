-- ============================================================
-- [트러블슈팅 노트] Facebook 사용자 친구 관계 분석
-- 
-- [1] 목표:
--   - Facebook 데이터베이스의 edges 테이블에서 양방향 친구 관계를 분석하여
--   - 각 사용자별 총 친구 수를 계산하고
--   - 친구 수 내림차순, 사용자 ID 오름차순으로 정렬
--
-- [2] 문제 상황과 해결 과정:
--   1. 친구 관계의 양방향성 처리:
--      - edges 테이블은 한 쪽 방향만 저장 (user_a_id -> user_b_id)
--      - UNION ALL로 반대 방향도 포함 (user_b_id -> user_a_id)
--      
--   2. 모든 사용자 포함:
--      - users 테이블을 기준으로 LEFT JOIN
--      - 친구가 없는 사용자도 결과에 포함되도록 처리
--   
--   3. 최종 집계:
--      - GROUP BY로 사용자별 친구 수 계산
--      - 친구 수 내림차순, 사용자 ID 오름차순 정렬
--
-- [3] 학습 포인트:
--   - WITH 절을 활용한 임시 테이블 생성
--   - UNION ALL로 양방향 데이터 처리
--   - LEFT JOIN으로 모든 사용자 포함
--   - 다중 정렬 조건 적용
-- ============================================================

WITH friends AS (
    -- 정방향 친구 관계 (A -> B)
    SELECT 
        user_a_id AS user_id, 
        user_b_id AS friend_id
    FROM edges
    UNION ALL
    -- 역방향 친구 관계 (B -> A)
    SELECT 
        user_b_id AS user_id, 
        user_a_id AS friend_id
    FROM edges
)
SELECT 
    A.user_id, 
    COUNT(B.friend_id) AS num_friends
FROM users A
LEFT JOIN friends B ON A.user_id = B.user_id
GROUP BY A.user_id
ORDER BY num_friends DESC, A.user_id ASC;
