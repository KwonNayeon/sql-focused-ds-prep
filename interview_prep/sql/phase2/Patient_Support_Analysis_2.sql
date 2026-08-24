SELECT
  round(count(case when call_category = 'n/a' or call_category is null then 1 end)*1.0/count(*)*100,1) as uncategorised_call_pct
FROM callers
;

-- Review Notes:
-- 2026-08-21:
-- call_category in ('n/a', NULL) 이런 식으로 in절 안에 NULL을 넣으면 call_category in ('n/a')와 같이 동작함. 그러므로 NULL 처리를 명시적으로 해주는 것이 중요
-- 2026-08-24: Null을 확인할 땐 is null, Null이 아닌 것을 확인할 땐 is not null을 사용해야 함. = Null은 틀린 문법
