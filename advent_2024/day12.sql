with class as (
  select
    classification,
    strftime('%Y', acquisition_date) as year,
    count(*) as count
  from artworks
  group by classification, strftime('%Y', acquisition_date)
)
select
  classification,
  sum(case when year = '2014' then count else 0 end) as '2014',
  sum(case when year = '2015' then count else 0 end) as '2015',
  sum(case when year = '2016' then count else 0 end) as '2016'
from class
group by classification
order by classification asc;
