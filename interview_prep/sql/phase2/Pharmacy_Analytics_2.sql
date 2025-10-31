-- drugs that resulted in losses
select
  manufacturer,
  count(drug) as drug_count,
  -sum(total_sales - cogs) as total_lose
from pharmacy_sales
where (total_sales - cogs) < 0
group by manufacturer
order by sum(total_sales - cogs) asc
;