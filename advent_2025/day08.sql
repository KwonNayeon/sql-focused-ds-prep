with conditions as (
  select
    wines.*,
    avg(density) over () as avg_density,
    avg(residual_sugar) over () as avg_residual_sugar,
    avg(case when color = 'white' then pH end) over () as avg_white_ph,
    avg(case when color = 'white' then citric_acid end) over () as avg_white_citric_acid
  from wines
)
select
  color,
  fixed_acidity,
  volatile_acidity,
  citric_acid,
  residual_sugar,
  chlorides,
  free_sulfur_dioxide,
  total_sulfur_dioxide,
  density,
  pH,
  sulphates,
  alcohol,
  quality
from conditions
where color = 'white'
and quality >= 7
and density > avg_density and residual_sugar > avg_residual_sugar
and pH < avg_white_ph and citric_acid > avg_white_citric_acid
;
