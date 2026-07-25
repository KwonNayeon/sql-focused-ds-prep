select
    inspection_type,
    count(case when risk_category is null then 1 end) as no_risk_results,
    count(case when risk_category = 'Low Risk' then 1 end) as low_risk_results,
    count(case when risk_category = 'Moderate Risk' then 1 end) as medium_risk_results,
    count(case when risk_category = 'High Risk' then 1 end) as high_risk_results,
    count(*) as total_inspections
from sf_restaurant_health_violations
group by inspection_type
;

-- Review Notes:
-- 2026-07-25: 복습, 칼럼명을 문자열('')로 감싸면 안 됨

