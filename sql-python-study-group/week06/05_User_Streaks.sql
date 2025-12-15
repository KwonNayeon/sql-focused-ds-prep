WITH unique_visits AS (
    SELECT DISTINCT user_id, date_visited
    FROM user_streaks
    WHERE date_visited <= '2022-08-10'
),
streak_groups AS (
    SELECT 
        user_id,
        date_visited,
        date_visited - ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date_visited)::INTEGER AS streak_id
    FROM unique_visits
),
streak_lengths AS (
    SELECT 
        user_id,
        COUNT(*) AS streak_length
    FROM streak_groups
    GROUP BY user_id, streak_id
),
longest_per_user AS (
    SELECT 
        user_id,
        MAX(streak_length) AS streak_length
    FROM streak_lengths
    GROUP BY user_id
),
ranked AS (
    SELECT 
        user_id,
        streak_length,
        DENSE_RANK() OVER (ORDER BY streak_length DESC) AS rnk
    FROM longest_per_user
)
SELECT user_id, streak_length
FROM ranked
WHERE rnk <= 3
ORDER BY streak_length DESC, user_id
;

-- Review Notes:
-- 2025-12-15: 복습하기
