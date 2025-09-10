-- 중복 title & description
with data as (
  select company_id
  from job_listings
  group by company_id, title, description
  having count(*) > 1
)
select count(*) as duplicate_companies
from data
;

-- 원래 쿼리와 동일한 결과, 조금 더 명시적
SELECT COUNT(DISTINCT company_id) as duplicate_companies
FROM (
  SELECT company_id
  FROM job_listings
  GROUP BY company_id, title, description
  HAVING COUNT(*) > 1
) duplicated_listings;