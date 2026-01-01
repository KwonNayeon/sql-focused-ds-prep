-- Count Occurrences Of Words In Drafts
-- lower words, and remove punctuation before counting
-- REGEXP_REPLACE('Hello, world! How are you?', '[[:punct:]]', '', 'g')
SELECT
    word,
    COUNT(*) as cnt
FROM google_file_store,
    LATERAL unnest(
        string_to_array(
            REGEXP_REPLACE(lower(contents), '[[:punct:]]', '', 'g'),
            ' '
        )
    ) as word
WHERE word != ''
GROUP BY word
ORDER BY cnt DESC
;

/*
-- 배열이 있을 때
SELECT unnest(ARRAY['사과', '바나나', '오렌지']);
```

**결과:**
```
사과
바나나
오렌지
*/
