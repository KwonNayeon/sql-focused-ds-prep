-- ============================================================
-- [트러블슈팅 노트] Data Science Skills
-- Filename: data_science_skills.sql
-- 
-- [1] 목표:
--   - candidates 테이블에서 Python, Tableau, PostgreSQL
--     세 가지 스킬을 모두 보유한 후보자 ID 추출
--
-- [2] 문제 해결 과정:
--   1. 스킬 필터링:
--      - WHERE IN으로 세 가지 스킬 중 하나라도 가진 후보자 필터
--      - 단순 AND 조건 사용 불가 (한 행에 한 스킬만 존재)
--   
--   2. 스킬 카운트:
--      - GROUP BY로 후보자별 그룹화
--      - HAVING으로 스킬 수 3개 이상 조건 설정
--      - COUNT(skill)로 각 후보자의 스킬 수 계산
--
-- [3] 학습 포인트:
--   - IN 연산자: 여러 값 중 하나와 일치하는지 확인
--   - GROUP BY + HAVING: 그룹 조건을 사용한 필터링
--   - 데이터 구조 이해: 한 행에 한 스킬만 있는 구조 파악
-- ============================================================

SELECT 
   candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) >= 3;
