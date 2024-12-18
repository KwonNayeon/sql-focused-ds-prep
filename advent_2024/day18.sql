with data as(
  select
    species,
    flipper_length_mm as x,
    body_mass_g as y
  from penguins
  where x is not null and y is not null
),
formula as (
  select
    species,
    count(*) as n,
    sum(x*Y) as sum_xy,
    sum(x) as sum_x,
    sum(y) as sum_y,
    sum(x*x) as sum_x2,
    sum(y*y) as sum_y2
  from data
  group by species
),
correlation as (
  select
    species,
    case
      when (n*sum_x2 - sum_x*sum_x)*(n*sum_y2 - sum_y*sum_y) = 0 then null
      else (n*sum_xy - sum_x*sum_y) / (sqrt((n*sum_x2 - sum_x*sum_x)*(n*sum_y2 - sum_y*sum_y)))
    end as corr
  from formula
)
select species, round(corr, 3) as corr
from correlation
;
