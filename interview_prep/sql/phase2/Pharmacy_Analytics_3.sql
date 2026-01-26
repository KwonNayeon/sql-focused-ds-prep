SELECT
  manufacturer,
  '$' || to_char(sum(total_sales) / 1000000, 'FM999,999') || ' million' as sale
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) desc, manufacturer asc
;
