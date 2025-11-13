SELECT
    ARTIST,
    COUNT(ID) AS N_OCCURRENCES
FROM spotify_worldwide_daily_song_ranking
GROUP BY ARTIST
ORDER BY 2 DESC;

-- Review Notes:
-- 2025-11-13: 쉬운 문제
