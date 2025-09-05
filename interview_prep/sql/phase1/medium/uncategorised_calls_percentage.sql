-- ============================================================
-- [트러블슈팅 노트] Advocate4Me 미분류 통화 비율 분석
-- Filename: uncategorised_calls_percentage.sql
-- 
-- [1] 목표:
--   - Advocate4Me 콜센터의 미분류 통화(n/a 또는 NULL) 비율 계산
--   - 결과를 소수점 첫째 자리까지 반올림하여 표시
--
-- [2] NULL 처리 전략:
--   - IS NULL 조건으로 빈 값 체크
--   - 'n/a' 문자열과 일치 여부 체크
-- ============================================================

SELECT
  round(100.0 * count(case when call_category is NULL or call_category = 'n/a' then 1 end)
  / count(*), 1) as uncategorised_call_pct
from callers
;
