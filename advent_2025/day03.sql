select
  species,
  body_mass_g
from penguins
where species is not null and body_mass_g is not null 
order by body_mass_g desc, species
;
