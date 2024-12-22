-- ============================================================
-- [트러블슈팅 노트] MoMA 미술관 소장품 연도별 통계 분석
-- 
-- [1] 목표:
--   - MoMA 미술관의 연도별 소장품 증가 추이를 분석
--   - Flow 지표(연간 신규 소장품 수)와 Stock 지표(누적 소장품 수) 계산
--   - 소장 연도 기준 오름차순 정렬된 데이터 제공
--
-- [2] 문제 상황과 해결 과정:
--   1. 날짜 데이터 처리:
--      - acquisition_date에서 연도만 추출 필요
--      - SQLite의 strftime 함수 활용하여 연도 추출
--      
--   2. 결측치 처리:
--      - acquisition_date가 NULL인 데이터 제외
--      - WHERE 절에서 IS NOT NULL 조건 적용
--   
--   3. 집계 데이터 생성:
--      - WITH 절로 연도별 기본 통계 생성
--      - 윈도우 함수로 누적합(Stock) 계산
--
-- [3] 학습 포인트:
--   - SQLite의 날짜 함수(strftime) 활용
--   - WITH 절을 통한 중간 집계 테이블 생성
--   - 윈도우 함수를 이용한 누적합 계산
--   - Flow/Stock 개념의 실제 데이터 적용
-- ============================================================

WITH annual_stats AS (
    SELECT 
        strftime('%Y', acquisition_date) AS year,
        COUNT(*) AS new_acquisitions
    FROM artworks
    WHERE acquisition_date IS NOT NULL
    GROUP BY strftime('%Y', acquisition_date)
)
SELECT 
    year AS "Acquisition year",
    new_acquisitions AS "New acquisitions this year (Flow)",
    SUM(new_acquisitions) OVER (ORDER BY year) AS "Total collection size (Stock)"
FROM annual_stats
ORDER BY year ASC;
