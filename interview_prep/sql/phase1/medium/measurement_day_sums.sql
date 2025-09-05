-- ============================================================
-- [트러블슈팅 노트] Extract odd/even sums by measurement day
-- Filename: measurement_day_sums.sql
-- 
-- [1] 목표:
--   - 측정 날짜별로 홀수/짝수 순번의 측정값 합계 추출
--   - 날짜, 홀수 순번 합계, 짝수 순번 합계 조회
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - 홀수/짝수를 구분하는 적절한 방법을 찾는데 어려움
--      - PostgreSQL에서 % 연산자로 홀짝 구분 가능함을 학습
--      - 날짜 형식을 'DD/MM/YYYY 00:00:00' 형태로 변환하는 방법 부재
--      
--   2. 해결 과정:
--      - 첫 시도: to_char() || '00:00:00' 형식으로 시도했으나 문제 accept 실패
--      - 최종 해결: date() 함수를 사용하여 시간 정보를 제거하는 방식으로 변경
--      - row_number()와 case when으로 홀짝 합계 계산 구현
--
-- [3] 학습 포인트:
--   - 윈도우 함수 활용:
--     * ROW_NUMBER()로 날짜별 순차적 번호 부여
--     * PARTITION BY로 날짜별 독립적 순번 관리
--   - 날짜 데이터 처리:
--     * date() 함수로 시간 정보 제거
--     * 날짜 기준 그룹핑과 정렬
--   - CASE WHEN을 활용한 조건부 집계:
--     * 홀수/짝수 순번 구분
--     * SUM과 CASE WHEN 조합으로 그룹별 합계 계산
-- ============================================================

with data as (
 select
   date(measurement_time) as measurement_day,
   measurement_value,
   row_number() over(partition by extract(day from measurement_time) 
                    order by measurement_time) as rank
 from measurements
)
SELECT
 measurement_day,
 sum(case when rank % 2 = 1 then measurement_value else 0 end) as odd_sum,
 sum(case when rank % 2 = 0 then measurement_value else 0 end) as even_sum
from data
group by measurement_day
order by measurement_day;
