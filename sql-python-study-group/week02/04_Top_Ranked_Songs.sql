SELECT
    trackname,
    COUNT(POSITION) AS CNT
FROM spotify_worldwide_daily_song_ranking
WHERE POSITION = 1
GROUP BY trackname
ORDER BY 2 DESC;

-- Review Notes:
-- 2025-11-13: 쉬운 문제
