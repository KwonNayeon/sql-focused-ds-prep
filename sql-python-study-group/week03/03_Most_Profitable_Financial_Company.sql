select
    continent,
    company
from forbes_global_2010_2014
where sector = 'Financials'
order by profits desc
limit 1
;