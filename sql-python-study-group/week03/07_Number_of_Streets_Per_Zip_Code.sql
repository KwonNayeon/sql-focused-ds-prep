with street_names as (
    select
        business_postal_code,
        lower(
            case when split_part(business_address, ' ', 1) ~ '^[0-9]+$' then split_part(business_address, ' ', 2)
                when split_part(business_address, ' ', 2) ~ '^[0-9]+$' then split_part(business_address, ' ', 1)
                else split_part(business_address, ' ', 1)
            end
        ) as street_name
    from sf_restaurant_health_violations
    where business_postal_code is not null
)
select
    business_postal_code,
    count(distinct street_name) as n_streets
from street_names
group by business_postal_code
order by n_streets desc, business_postal_code asc;

/*
case 
    -- 첫 번째 단어가 숫자인 경우 (예: "27 Drumm St")
    when split_part(business_address, ' ', 1) ~ '^[0-9]+$' 
        then split_part(business_address, ' ', 2)  -- 두 번째 단어를 street name으로 사용 ("Drumm")
    
    -- 두 번째 단어가 숫자인 경우 (예: "Pier 39")
    when split_part(business_address, ' ', 2) ~ '^[0-9]+$' 
        then split_part(business_address, ' ', 1)  -- 첫 번째 단어를 street name으로 사용 ("Pier")
    
    -- 그 외의 경우 (예: "Market Street")
    else split_part(business_address, ' ', 1)      -- 첫 번째 단어를 street name으로 사용 ("Market")
end

정규식 설명:
- `~`: PostgreSQL의 정규식 매칭 연산자
- `'^[0-9]+$'`: 
  - `^`: 문자열 시작
  - `[0-9]+`: 1개 이상의 숫자
  - `$`: 문자열 끝
  - 즉, 오직 숫자로만 구성된 문자열

결과:
- "27 Drumm St" → "drumm"
- "Pier 39" → "pier"  
- "Market Street" → "market"
*/
