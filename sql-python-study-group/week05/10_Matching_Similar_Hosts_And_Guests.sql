-- Matching Similar Hosts and Guests
select
    distinct h.host_id,
    g.guest_id
from airbnb_hosts h
inner join airbnb_guests g
on h.gender = g.gender and h.nationality = g.nationality
order by h.host_id
;

-- Q1: Multiple pairs가 발생하면?
-- A: 같은 gender & nationality를 가진 모든 host-guest 조합이 생성됨
--    예: host 2명(M, Korea), guest 2명(M, Korea) → 4개 pairs 생성 (2×2 카테시안 곱)

-- Q2: Inner join을 쓴 이유?
-- A: 둘 다 같은 gender & nationality를 가진 경우만 필터링
