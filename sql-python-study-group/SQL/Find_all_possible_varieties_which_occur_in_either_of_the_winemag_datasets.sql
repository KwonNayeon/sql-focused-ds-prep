select distinct variety
from winemag_p1
union
select distinct variety
from winemag_p2
;

-- Review Notes:
-- 2026-07-26: 복습, 각 테이블의 중복을 제거한 값 추출 -> union으로 중복없이 병합
