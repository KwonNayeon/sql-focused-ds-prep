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
--      - WHERE절에서 직접 MIN(issue_year)를 사용하려 시도
--      - GROUP BY 없이 aggregate function 사용 불가 에러 발생
--      
--   2. WHERE IN 절을 활용한 해결:
--      - 서브쿼리에서 각 카드별 최초 발급 시점(연도,월) 추출
--      - 카드명, 연도, 월을 한번에 비교하여 최초 발급 데이터 획득
--
-- [3] 학습 포인트:
--   - WHERE절에서 aggregate function 직접 사용 불가
--   - 서브쿼리를 통한 그룹별 최솟값 비교 방법
--   - WHERE IN과 복합 컬럼 조건 활용
-- ============================================================

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
