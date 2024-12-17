-- 트러블슈팅 노트:
-- ============================================================
-- [1] 목표
--   - 각 게임(name)이 Sony, Nintendo, Microsoft 중
--     두 개 이상의 대분류에 속해 있는지 확인하고 조회.
-- ============================================================
-- [2] 문제 상황과 해결 과정
--   1. 대분류 생성 (main_category):
--      - 특정 플랫폼(platform)에 따라 'Sony', 'Nintendo', 'Microsoft'를 구분.
--      - 나머지 플랫폼은 'etc.'로 분류.
--      - 이 과정을 위해 CASE 문을 사용함.
--        -> 중복된 게임과 카테고리를 제거하기 위해 DISTINCT 적용.
--      
--   2. 두 개 이상의 대분류 확인:
--      - 동일한 게임이 여러 플랫폼에서 출시될 수 있음.
--      - COUNT(main_category)를 사용할 경우 중복을 포함해 계산되므로,
--        정확한 대분류 개수를 구하기 위해 COUNT(DISTINCT)를 사용.
--      - 중복 제거된 고유 대분류 개수만 계산.
--     
--   3. 결과 필터링:
--      - GROUP BY를 통해 게임별 대분류 개수를 계산하고,
--        조건: COUNT(DISTINCT) >= 2를 만족하는 게임만 필터링.
-- ============================================================
-- [3] 최종 쿼리
WITH
  category AS (
    SELECT DISTINCT A.name,
      CASE
        WHEN B.name IN ('PS3', 'PS4', 'PSP', 'PSV') THEN 'Sony'
        WHEN B.name IN ('Wii', 'WiiU', 'DS', '3DS') THEN 'Nintendo'
        WHEN B.name IN ('X360', 'XONE') THEN 'Microsoft'
        ELSE 'etc.'
      END AS main_category
    FROM
      games A
      LEFT JOIN platforms B ON A.platform_id = B.platform_id
    WHERE
      A.year >= '2012'
  ),
  category_count AS (
    SELECT 
      name, 
      COUNT(DISTINCT main_category) AS count  -- 고유한 대분류 개수 계산
    FROM 
      category
    WHERE 
      main_category IN ('Sony', 'Nintendo', 'Microsoft') -- 주요 대분류만 필터링
    GROUP BY 
      name
  )
SELECT 
  name  -- 두 개 이상의 대분류에 속하는 게임 조회
FROM 
  category_count
WHERE 
  count >= 2;  -- 조건: 두 개 이상의 대분류
-- ============================================================
-- [4] 학습 포인트
--   1. DISTINCT 사용:
--      - SELECT DISTINCT로 중복된 게임과 플랫폼을 제거.
--      - COUNT(DISTINCT)를 통해 중복된 값을 제외하고 고유 개수를 계산.
--    
--   2. CASE 문으로 대분류 생성:
--      - CASE WHEN을 활용해 플랫폼 별로 카테고리를 지정.
--     
--   3. COUNT의 역할:
--      - 일반 COUNT()는 중복된 값을 포함해 계산.
--      - COUNT(DISTINCT)는 고유 값만 세어 정확한 개수를 반환.
--     
--   4. GROUP BY와 HAVING:
--      - GROUP BY로 게임 단위로 묶어 개수를 계산하고,
--      - HAVING 또는 WHERE 절에서 조건을 필터링.
--     
--   5. 논리 흐름 유지:
--      - WITH 문(CTE)을 통해 쿼리 단계를 논리적으로 분리해 작성.
--      - 코드 가독성과 디버깅이 쉬워짐.
