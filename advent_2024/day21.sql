-- ============================================================
-- [트러블슈팅 노트] GA 세션 데이터 재정의 분석
-- 
-- [1] 목표:
--   - GA 세션 종료 기준을 30분에서 10분으로 변경
--   - 특정 사용자('a8Xu9GO6TB')의 세션을 재정의하여 새로운 세션 ID 부여
--   - 이벤트 발생 시각순으로 1부터 시작하는 자연수로 세션 ID 부여
--
-- [2] 문제 상황과 해결 과정:
--   1. 이전 이벤트와의 시간 간격 계산 문제:
--      - LAG() 함수 사용법 파악이 필요했음
--      - LAG(column) OVER (ORDER BY column)의 형태로 이전 행 값 참조 가능
--      - 첫 행의 경우 이전 값이 없어 NULL 반환됨을 확인
--      
--   2. 시간 차이 계산 시 발생한 문제들:
--      - 단순 숫자 뺄셈으로는 정확한 시간 차이를 구할 수 없었음
--      - strftime('%s', datetime())을 사용해 Unix timestamp(초 단위)로 변환
--      - 600초(10분) 기준으로 새로운 세션 여부 판단
--   
--   3. NULL 처리 관련 이슈:
--      - 처음에 'column = null' 로 잘못된 비교
--      - IS NULL 연산자를 사용하여 올바르게 수정
--      - previous_event_time IS NULL 조건으로 첫 이벤트 처리
--
--   4. 세션 ID 부여 로직 구현:
--      - is_new_session 컬럼에 새 세션 시작점을 1로 표시
--      - SUM() OVER (ORDER BY)로 누적합 계산
--      - 누적합이 자동으로 1부터 순차적으로 증가하는 세션 ID가 됨
--
-- [3] 핵심 학습 포인트:
--   - Window 함수의 이해:
--     * LAG(): 이전 행의 값을 참조하는 방법
--     * SUM() OVER(): 누적합을 계산하는 방법
--   
--   - SQLite 날짜/시간 처리:
--     * strftime()과 datetime() 함수로 시간 차이 계산
--     * Unix timestamp 활용한 시간 간격 계산
--   
--   - NULL 처리:
--     * IS NULL 연산자의 올바른 사용
--     * Window 함수에서 NULL이 처리되는 방식
--
--   - 데이터 변환 테크닉:
--     * 0, 1 값을 활용한 누적합으로 순차적 ID 생성
--     * CTE를 활용한 단계적 데이터 처리
-- ============================================================

WITH events_with_prev AS (
   SELECT
       user_pseudo_id,
       event_timestamp_kst,
       event_name,
       ga_session_id,
       LAG(event_timestamp_kst) OVER (ORDER BY event_timestamp_kst) AS previous_event_time
   FROM ga
   WHERE user_pseudo_id = 'a8Xu9GO6TB'
   ORDER BY event_timestamp_kst
),
session_breaks AS (
   SELECT
       *,
       CASE
           WHEN (strftime('%s', datetime(event_timestamp_kst)) -
                strftime('%s', datetime(previous_event_time))) >= 600
                OR previous_event_time IS NULL THEN 1 
           ELSE 0 
       END AS is_new_session
   FROM events_with_prev
)
SELECT 
   user_pseudo_id,
   event_timestamp_kst,
   event_name,
   ga_session_id,
   SUM(is_new_session) OVER (ORDER BY event_timestamp_kst) AS new_session_id
FROM session_breaks;
