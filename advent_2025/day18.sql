-- 1단계: 양방향 엣지 만들기 (친구는 양방향이기 때문)
WITH bidirectional_edges AS (
    SELECT user_a_id AS user_id, user_b_id AS friend_id
    FROM edges
    UNION ALL
    SELECT user_b_id AS user_id, user_a_id AS friend_id
    FROM edges
),
-- 2단계: 각 사용자가 친구를 몇 명 가지고 있는지 계산
friend_counts AS (
    SELECT 
        user_id,
        COUNT(*) AS friend_count
    FROM bidirectional_edges
    GROUP BY user_id
),
-- 3단계: 후보자의 친구들 친구 수 합계 계산
candidate_scores AS (
    SELECT 
        be.user_id,
        fc1.friend_count AS friends,
        SUM(fc2.friend_count) AS friends_of_friends
    FROM bidirectional_edges be
    JOIN friend_counts fc1 ON be.user_id = fc1.user_id  -- 후보자의 친구 수
    JOIN friend_counts fc2 ON be.friend_id = fc2.user_id  -- 각 친구의 친구 수
    WHERE fc1.friend_count >= 100  -- 친구 100명 이상만
    GROUP BY be.user_id, fc1.friend_count
)
SELECT 
    user_id,
    friends,
    friends_of_friends,
    ROUND(CAST(friends_of_friends AS FLOAT) / friends, 2) AS ratio
FROM candidate_scores
ORDER BY ratio DESC
LIMIT 5;
