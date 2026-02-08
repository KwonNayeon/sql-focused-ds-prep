-- dense_rank: 갭 없이 순위 부여, 동일한 값에 대해서 동일 순위 부여
-- 먼저 id_guest별 message의 합 구하기 -> 순위 매기기
with rank as (
    select
        id_guest,
        sum(n_messages) as n_messages
    from airbnb_contacts
    group by id_guest
)
select
    dense_rank() over (order by n_messages desc) as ranking,
    id_guest,
    n_messages
from rank
;

-- Review Notes:
-- 2026-02-07: 복습 완료
