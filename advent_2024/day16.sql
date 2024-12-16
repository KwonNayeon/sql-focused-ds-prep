-- 트러블슈팅 노트: 내가 실수했던 점, 자주 물어봤던 내용, 개선한 부분 정리

-- 1. 연속된 연도를 식별하는 방법
--    - 초기에는 MIN(year)와 MAX(year)를 단순 비교해 연속 여부를 판단하려 했으나, 
--      중간에 빠진 연도가 있어도 "연속"으로 처리되는 문제가 발생.
--    - 해결:
--        - ROW_NUMBER()를 활용해 각 연도에 순번을 부여하고, year - ROW_NUMBER()를 계산.
--        - 같은 작가(author)의 연속된 연도는 동일한 group_id 값을 가지도록 처리.

-- 2. LAG/ROW_NUMBER 사용 이해 부족
--    - LAG는 이전 행의 값을 가져오는 데 사용하고, ROW_NUMBER()는 순차적 번호를 부여.
--    - 처음에는 LAG를 사용해 연속 여부를 판단하려 했으나, 연속된 그룹 전체를 식별하는 데 어려움.
--    - 해결:
--        - ROW_NUMBER()와 year의 차이를 활용해 같은 그룹을 식별.

-- 3. 중간 테이블(CTE) 활용
--    - 한 번에 모든 처리를 하려다가 쿼리가 복잡해지고 디버깅이 어려웠음.
--    - 해결:
--        - 연속된 연도를 식별하는 작업을 WITH로 나누어 가독성과 유지보수성 개선:
--            - fiction: 조건에 맞는 데이터를 추출.
--            - year_group: ROW_NUMBER()로 그룹화 처리.
--            - consecutive_years: 연속된 연도의 길이를 계산하고 조건 필터링.

WITH fiction AS (
  SELECT
    DISTINCT author, year -- 1. 장르가 'Fiction'인 데이터에서 중복 제거
  FROM books
  WHERE genre = 'Fiction'
),
year_group AS (
  SELECT
    author,
    year,
    year - ROW_NUMBER() OVER (PARTITION BY author ORDER BY year) AS group_id -- 2. 연속된 연도 그룹 생성
  FROM fiction
),
consecutive_years AS (
  SELECT
    author,
    MAX(year) AS year, -- 3. 그룹별 마지막 연도
    COUNT(*) AS depth -- 4. 그룹별 연속된 연도의 개수 계산
  FROM year_group
  GROUP BY author, group_id -- 5. 그룹별 집계
  HAVING COUNT(*) >= 5 -- 6. 연속된 연도가 5년 이상인 그룹만 필터링
)
SELECT *
FROM consecutive_years;
