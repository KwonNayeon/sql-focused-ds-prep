-- ============================================================
-- [트러블슈팅 노트] Duplicate Job Listings
-- Filename: duplicate_job_listings.sql
-- 
-- [1] 목표:
--   - 동일한 회사에서 같은 제목과 설명으로 중복 등록된
--   - 채용공고의 수를 집계
--
-- [2] 문제 해결 과정:
--   1. 중복 데이터 식별:
--      - company_id, title, description을 기준으로 그룹화
--      - COUNT(*)로 각 그룹의 발생 빈도 계산
--   
--   2. 중복 필터링:
--      - cnt >= 2 조건으로 2회 이상 등록된 공고만 추출
--      - 최종적으로 중복 게시된 공고의 총 수 계산
--
-- [3] 학습 포인트:
--   - GROUP BY의 복합키 활용:
--     * 여러 컬럼을 기준으로 그룹화 가능
--   - WITH 절을 활용한 단계적 접근:
--     * 복잡한 로직을 단계별로 분리하여 가독성 향상
--   - 중복 데이터 처리:
--     * COUNT와 WHERE 절을 활용한 중복 식별
-- ============================================================

WITH duplicate_check AS (
   SELECT 
       company_id, 
       title, 
       description, 
       COUNT(*) AS cnt
   FROM job_listings
   GROUP BY 
       company_id, 
       title, 
       description
),
filtered_duplicates AS (
   SELECT *
   FROM duplicate_check
   WHERE cnt >= 2
)
SELECT 
   COUNT(*) AS duplicate_companies
FROM filtered_duplicates;
