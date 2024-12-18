-- ============================================================
-- [트러블슈팅 노트]
--
-- [1] 목표:
--   - 각 게임(name)이 Sony, Nintendo, Microsoft 중
--     두 개 이상의 대분류에 속해 있는지 확인하고 조회.
--
-- [2] 문제 상황과 해결 과정:
--   1. 대분류 생성 (main_category):
--      - 플랫폼(platform)에 따라 'Sony', 'Nintendo', 'Microsoft'를 구분.
--      - 나머지 플랫폼은 'etc.'로 분류.
--      - 이를 위해 CASE 문을 사용하여 조건별로 카테고리 지정.
--      - 중복된 게임-카테고리 조합을 제거하기 위해 DISTINCT 사용.
--   
--   2. 두 개 이상의 대분류 확인:
--      - 동일 게임이 여러 플랫폼에서 출시 가능성을 고려.
--      - COUNT(main_category)를 사용할 경우 중복을 포함하므로,
--        COUNT(DISTINCT)를 사용해 고유 대분류 개수만 계산.
--   
--   3. 결과 필터링:
--      - GROUP BY로 게임별로 묶고, 대분류 개수를 계산.
--      - HAVING 절을 사용하여 COUNT(DISTINCT) >= 2를 만족하는
--        게임만 필터링.
--
-- [3] 학습 포인트:
--   1. DISTINCT 사용:
--      - 중복 제거를 위한 SELECT DISTINCT와
--        고유 값을 계산하는 COUNT(DISTINCT)의 차이점 이해.
--   
--   2. CASE 문 활용:
--      - 조건에 따라 플랫폼을 Sony, Nintendo, Microsoft, etc.로 분류.
--   
--   3. COUNT와 DISTINCT 차이:
--      - COUNT()는 중복 포함, COUNT(DISTINCT)는 중복 제거.
--   
--   4. GROUP BY와 HAVING:
--      - GROUP BY로 데이터를 그룹화하고 HAVING으로 조건 필터링.
--   
--   5. WITH 문(CTE)의 이점:
--      - CTE로 쿼리를 단계적으로 나눠 가독성과 디버깅 용이성 향상.
-- ============================================================

with
  category as (
    select distinct A.name,
      case
        when B.name in ('PS3', 'PS4', 'PSP', 'PSV') then 'Sony'
        when B.name in ('Wii', 'WiiU', 'DS', '3DS') then 'Nintendo'
        when B.name in ('X360', 'XONE') then 'Microsoft'
        else 'etc.'
      end as main_category
    from
      games A
      left join platforms B on A.platform_id = B.platform_id
    where
      A.year >= '2012'
  ),
category_count as (
  select name, count(distinct main_category) as count 
  from category
  where main_category in ('Sony', 'Nintendo', 'Microsoft')
  group by name
)
select name
from category_count
where count >= 2
;
