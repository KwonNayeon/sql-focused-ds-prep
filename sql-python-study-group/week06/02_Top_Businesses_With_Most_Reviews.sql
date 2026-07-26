with rank as (
    select
        business_id,
        name,
        review_count,
        rank() over (order by review_count desc) as review_rn
    from yelp_business
)
select
    name,
    review_count
from rank
where review_rn < 6
;

-- Review Notes:
-- 2026-07-26: 복습
-- RANK() 사용 이유: 리뷰 수가 동점이면 같은 순위를 부여하고, 그다음 순위는 동점 개수만큼 건너뛰어야 하기 때문
