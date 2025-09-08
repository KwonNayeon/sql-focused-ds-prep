-- WHERE: 개별 행을 필터링 (Python, Tableau, PostgreSQL 중 하나라도 가진 행)
-- HAVING: 그룹별 조건 확인 (각 candidate가 3개 스킬을 모두 가지는지)
-- 실행 순서: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
select candidate_id
from candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(distinct skill) = 3
order by candidate_id asc
;