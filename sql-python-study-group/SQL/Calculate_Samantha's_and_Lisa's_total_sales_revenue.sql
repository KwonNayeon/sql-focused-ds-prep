select
    sum(sales_revenue) as total_revenue
from sales_performance
where salesperson in ('Samantha', 'Lisa')
;
