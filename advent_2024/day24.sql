-- ============================================================
-- [트러블슈팅 노트] Facebook 친구 관계에서 세 명의 상호 친구 찾기
-- 
-- [1] 목표:
--   - ID가 3820인 사용자를 포함해 세 명의 사용자가 모두 서로 친구인 경우 찾기
--   - user_a_id < user_b_id < user_c_id 조건을 만족하는 조합만 출력
--   - 양방향 친구 관계 고려 (A->B이면 B->A도 친구)
--
-- [2] 어려웠던 점들:
--   1. 복잡한 조건 처리:
--      - 3820이 무조건 포함되어야 하지만 위치가 고정되지 않음
--      - ID들이 항상 오름차순이어야 함 (user_a_id < user_b_id < user_c_id)
--      - 세 사용자가 모두 서로 친구여야 함 (양방향 관계 고려)
--   
--   2. 초기 접근 방식의 한계:
--      - 3820을 특정 위치에 고정하면 일부 케이스를 놓치게 됨
--      - ID 정렬 조건을 단순 비교로만 처리하면 복잡한 케이스 처리 어려움
--      - 양방향 관계를 고려하지 않으면 친구 관계 누락 발생
--
-- [3] 해결 전략:
--   1. 케이스 분리:
--      - 3820의 위치에 따라 세 가지 케이스로 나눔
--      - 각 케이스별로 ID 순서 조건을 개별 적용
--      
--   2. 양방향 친구 관계 처리:
--      - all_friends CTE로 양방향 관계 테이블 생성
--      - EXISTS로 실제 친구 관계 확인
--   
--   3. ID 정렬 보장:
--      - 각 UNION 쿼리마다 3820과의 대소 관계를 명시
--      - JOIN 조건에서 friend_id 간 대소 관계 지정
--
-- [4] 핵심 학습:
--   - 복잡한 조건은 개별 케이스로 나누어 해결
--   - WITH 절을 활용한 임시 데이터 처리
--   - UNION을 통한 다중 케이스 결합
--   - EXISTS를 활용한 조건 검증
-- ============================================================

WITH friends_of_3820 AS (
   -- 3820의 모든 친구를 찾는 CTE
   SELECT DISTINCT
   CASE
       WHEN user_a_id = 3820 THEN user_b_id
       ELSE user_a_id
   END as friend_id
   FROM edges
   WHERE user_a_id = 3820 OR user_b_id = 3820
),
all_friends AS (
   -- 양방향 친구 관계를 만드는 CTE
   -- A->B면 B->A도 친구 관계로 포함
   SELECT user_a_id as user1, user_b_id as user2 FROM edges
   UNION
   SELECT user_b_id as user1, user_a_id as user2 FROM edges
)
-- 케이스 1: 3820이 가장 큰 ID (user_c_id)인 경우
SELECT DISTINCT
   t1.friend_id as user_a_id,
   t2.friend_id as user_b_id,
   3820 as user_c_id
FROM friends_of_3820 t1
JOIN friends_of_3820 t2 ON t1.friend_id < t2.friend_id
WHERE EXISTS (
   SELECT 1 FROM all_friends f
   WHERE (f.user1 = t1.friend_id AND f.user2 = t2.friend_id)
)
AND t1.friend_id < 3820 AND t2.friend_id < 3820

UNION

-- 케이스 2: 3820이 중간 ID (user_b_id)인 경우
SELECT DISTINCT
   t1.friend_id as user_a_id,
   3820 as user_b_id,
   t2.friend_id as user_c_id
FROM friends_of_3820 t1
JOIN friends_of_3820 t2 ON t1.friend_id < t2.friend_id
WHERE EXISTS (
   SELECT 1 FROM all_friends f
   WHERE (f.user1 = t1.friend_id AND f.user2 = t2.friend_id)
)
AND t1.friend_id < 3820 AND t2.friend_id > 3820

UNION

-- 케이스 3: 3820이 가장 작은 ID (user_a_id)인 경우
SELECT DISTINCT
   3820 as user_a_id,
   t1.friend_id as user_b_id,
   t2.friend_id as user_c_id
FROM friends_of_3820 t1
JOIN friends_of_3820 t2 ON t1.friend_id < t2.friend_id
WHERE EXISTS (
   SELECT 1 FROM all_friends f
   WHERE (f.user1 = t1.friend_id AND f.user2 = t2.friend_id)
)
AND t1.friend_id > 3820 AND t2.friend_id > 3820
ORDER BY user_a_id, user_b_id, user_c_id;