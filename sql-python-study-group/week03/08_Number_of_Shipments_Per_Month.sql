-- 두 컬럼의 unique 조합 개수: COUNT(DISTINCT (col1, col2))
select
    to_char(shipment_date, 'YYYY-MM') as year_month,
    count(distinct(shipment_id, sub_id)) as n_shipment
from amazon_shipment
group by year_month
;
