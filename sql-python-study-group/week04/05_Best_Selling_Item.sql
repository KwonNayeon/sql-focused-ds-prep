-- Best Selling Item
/*
조건: 
1. No need to separate months by year
2. To calculate sales, ignore returns and cancellations

SUM을 해야 하는 이유:
- 같은 상품이 한 달에 여러 번 판매되기 때문
*/
with monthly_item_sales as (
    select
        extract(month from invoicedate) as month,
        description,
        sum(unitprice * quantity) as total_paid
    from online_retail
    where invoiceno not like '%C%'
    group by extract(month from invoicedate), description
),
ranked_items as (
    select
        month,
        description,
        total_paid,
        rank() over (partition by month order by total_paid desc) as rn
    from monthly_item_sales
)
select
    month,
    description,
    total_paid
from ranked_items
where rn = 1
;
-- Review Notes:
-- 2025-11-30: 복습하기, 처음에 풀 때 조건 실수를 많이 함
