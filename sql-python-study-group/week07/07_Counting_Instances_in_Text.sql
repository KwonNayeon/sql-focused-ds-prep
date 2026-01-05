-- Counting Instances in Text
select
    word,
    count(*) as cnt
from google_file_store,
    lateral unnest(
        string_to_array(REGEXP_REPLACE(lower(contents), '[[:punct:]]', '', 'g'),
            ' '
        )
    ) as word
where word in ('bull', 'bear')
group by word
;

/*
contents: "Bull market is strong. Bear market too."

1. lower: "bull market is strong. bear market too."
2. REGEXP_REPLACE(쉼표, 마침표 등 제거): "bull market is strong bear market too"
3. string_to_array: ['bull', 'market', 'is', 'strong', 'bear', 'market', 'too']
4. UNNEST: 각 단어가 별도 행으로
   bull
   market
   is
   strong
   bear
   market
   too
5. WHERE 필터링: bull, bear만 남음
6. GROUP BY로 카운트
*/
