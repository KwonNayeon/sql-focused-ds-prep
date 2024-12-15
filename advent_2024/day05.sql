-- 언더스코어(_) 포함 여부 처리 쿼리
-- 1. '_'는 SQL에서 기본적으로 "임의의 단일 문자"를 의미 (와일드카드).
-- 2. ESCAPE 문을 사용해 '_'를 문자 그대로 비교.
--    - 예: '%\_%' ESCAPE '\' -> \_는 언더스코어를 문자로 처리.
-- 3. 백슬래시(\)를 두 번 사용하는 이유:
--    - 첫 번째 \: SQL이 백슬래시를 문자로 인식하도록 이스케이프.
--    - 두 번째 \: '_'를 와일드카드가 아닌 문자로 비교.

select DISTINCT 
    page_location
from 
    ga
where 
    page_location not like '%\_%' ESCAPE '\' -- 언더스코어(_)가 포함되지 않은 값 필터링
order by 
    page_location asc;
