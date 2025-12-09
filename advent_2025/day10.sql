-- 한 선수가 여러 개의 메달을 가진 경우 메달 종류를 쉼표(,)로 붙여 하나의 컬럼에 출력되도록 해야함
SELECT
    distinct a.id,
    a.name,
    GROUP_CONCAT(r.medal ORDER BY r.medal SEPARATOR ', ') AS medals
FROM athletes a 
JOIN records r ON a.id = r.athlete_id
JOIN teams t ON r.team_id = t.id
JOIN events e ON e.id = r.event_id
JOIN games g ON g.id = r.game_id
WHERE e.event = 'Volleyball Women''s Volleyball'
AND t.team = 'KOR'
AND r.medal IS NOT NULL
GROUP BY a.id, a.name
;
