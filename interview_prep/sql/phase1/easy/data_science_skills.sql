SELECT 
   candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3;

-- Review Notes:
-- 2026-08-28: 간단한 문제는 cte 없이 해결하기
