-- ============================================================
-- [트러블슈팅 노트] 카드별 최초 발급 데이터 조회
-- Filename: first_card_issuance.sql
-- 
-- [1] 목표:
--   - 각 카드의 최초 발급(가장 빠른 연도,월) 시점의 발급량 조회
--   - 발급량 기준 내림차순 정렬
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - WHERE IN 절을 사용하여 최초 발급 데이터 추출 시도
--      - 연도와 월을 별도로 비교하는 방식의 한계
--      
--   2. Window 함수를 활용한 해결:
--      - make_date()로 연도와 월을 날짜 형식으로 변환
--      - partition by와 min() window 함수로 카드별 최초 발급일 계산
--      - CTE를 활용하여 코드 가독성 향상
--
-- [3] 학습 포인트:
--   - make_date() 함수를 통한 날짜 데이터 변환
--   - Window 함수와 partition by를 활용한 그룹별 집계
--   - CTE(Common Table Expression)를 통한 쿼리 구조화
-- ============================================================

-- My Solution (Passed but needs improvement)
SELECT
  card_name,
  issued_amount
from monthly_cards_issued
where (card_name, issue_year, issued_amount) in 
  (select
    card_name,
    min(issue_year),
    min(issued_amount)
  from monthly_cards_issued
  group by card_name
  )
order by issued_amount desc
;

-- Optimal Solution
with card_launch as (
  SELECT
    card_name,
    issued_amount,
    make_date(issue_year, issue_month, 1) as issue_date,
    min(make_date(issue_year, issue_month, 1)) over (
      partition by card_name) as launch_date
  from monthly_cards_issued
)
SELECT
  card_name,
  issued_amount
from card_launch
where issue_date = launch_date
order by issued_amount desc
