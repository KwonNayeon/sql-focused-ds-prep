-- 트러블슈팅 노트:
-- 1. 실수했던 부분:
--    - publisher_id와 developer_id 혼동: 개발사 데이터를 조회해야 하는데 퍼블리셔 데이터를 잘못 참조함
--    - 잘못된 코드: A.publisher_id = B.company_id
--    - 올바른 코드: A.developer_id = B.company_id

-- 2. 쿼리 구조:
--    - platform_sales CTE:
--        * 개발사별, 플랫폼별 총 판매량 계산
--        * 각 지역 판매량(sales_na, sales_eu 등)을 합산
--        * developer_id로 그룹화하여 플랫폼별 총 판매량 산출
--    - ranked_sales CTE:
--        * rank() 함수 사용: 개발사별(platform_sales의 developer 기준) 판매량이 가장 높은 플랫폼 식별
--        * PARTITION BY developer: 개발사별로 순위를 매김
--        * ORDER BY total_sales DESC: 총 판매량 내림차순 정렬
--    - 최종 SELECT:
--        * ranked = 1인 레코드만 추출: 개발사별 가장 높은 판매량을 기록한 플랫폼 반환
--        * 동률 발생 시 해당 플랫폼 모두 출력

with platform_sales as (
  select B.name as developer, C.name as platform, sum(A.sales_na + A.sales_eu + A.sales_jp + A.sales_other) as total_sales
  from games A
  join companies B on A.developer_id = B.company_id
  join platforms C on A.platform_id = C.platform_id
  group by A.developer_id, C.platform_id
),
ranked_sales as (
  select developer, platform, total_sales, rank() over (partition by developer order by total_sales desc) as ranked
  from platform_sales
)
select developer, platform, total_sales as sales
from ranked_sales
where ranked = 1
;
