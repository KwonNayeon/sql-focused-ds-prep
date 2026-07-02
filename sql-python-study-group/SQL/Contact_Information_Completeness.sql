select
    (count(case when phone_number is null then 1 end)*1.0/count(*)) as missing_phone_ratio
from techcorp_workforce
;
