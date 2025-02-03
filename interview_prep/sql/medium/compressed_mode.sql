-- ============================================================
-- [트러블슈팅 노트] Maximum Value와 연관 데이터 추출
-- Filename: compressed_mode.sql
-- 
-- [1] 목표:
--   - 특정 열의 최대값을 가진 행의 다른 열 데이터 추출
--   - Alibaba 주문 데이터에서 가장 많이 발생한 주문 품목 수 찾기
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - SELECT max(order_occurrences)만으로는 해당 행의 item_count를 가져올 수 없음
--      - 단순 max() 함수로는 연관된 열 데이터 추출 불가
--      
--   2. 서브쿼리를 활용한 해결:
--      - WITH절로 최대값 먼저 찾기
--      - WHERE절에서 서브쿼리로 최대값과 일치하는 행 찾기
--      - order_occurrences = (SELECT MAX(order_occurrences) FROM items_per_order)
--
-- [3] 학습 포인트:
--   - 서브쿼리의 활용:
--     * 최대값과 같은 값을 가진 행 전체 추출 방법
--     * WHERE절에서 서브쿼리로 조건 설정하는 패턴
--   - 실무에서 자주 사용되는 패턴:
--     * 통계값(최대/최소)과 연관된 다른 데이터 추출할 때 유용
--     * 데이터 분석에서 최빈값이나 특이값 찾을 때 활용
-- ============================================================

어떠세요? 서브쿼리를 처음 사용해보셨다고 하셔서, 그 부분에 초점을 맞춰서 정리해보았습니다! 😊

with max as (
  SELECT
    max(order_occurrences) as max
  from items_per_order
)
select
  item_count as mode
from items_per_order
where order_occurrences = (select max(order_occurrences) as max from items_per_order)
