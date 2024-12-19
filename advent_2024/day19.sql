-- ============================================================
-- [트러블슈팅 노트] 카페 주소 데이터 정제
-- 
-- [1] 목표:
--   - 전국 카페 장소 데이터에서 주소(address) 컬럼을 정제하여
--   - 시도(sido)와 시군구(sigungu) 단위로 카페 수를 집계
--
-- [2] 문제 상황과 해결 과정:
--   1. 주소 데이터 분리:
--      - INSTR로 첫 번째 공백 위치(first_space) 찾기
--      - 첫 번째 공백 이후 문자열에서 두 번째 공백 위치(second_space) 찾기
--      
--   2. 시도/시군구 추출:
--      - SUBSTR 함수로 첫 번째 공백 이전까지를 sido로 추출
--      - 첫 번째 공백부터 두 번째 공백까지를 sigungu로 추출
--      - TRIM 함수로 추출된 값의 앞뒤 공백 제거
--   
--   3. 데이터 집계:
--      - GROUP BY로 sido, sigungu 기준 집계
--      - ORDER BY count(*) DESC로 카페 수 많은 순 정렬
--
-- [3] 학습 포인트:
--   - INSTR 함수: 문자열 내 특정 문자의 위치를 찾는 함수
--   - SUBSTR 함수: 문자열의 일부를 추출하는 함수
--   - WITH 절 활용: step1, step2로 단계를 나누어 가독성 향상
--   - 명확한 변수명: first_space, second_space 등 직관적인 변수명 사용
-- ============================================================

WITH step1 AS (
   SELECT
       address,
       INSTR(address, ' ') AS first_space
   FROM cafes
),
step2 AS (
   SELECT
       address,
       first_space,
       INSTR(SUBSTR(address, first_space + 1), ' ') AS second_space
   FROM step1
)
SELECT
   TRIM(SUBSTR(address, 1, first_space - 1)) AS sido,
   TRIM(SUBSTR(address, first_space + 1, second_space)) AS sigungu,
   COUNT(*) AS cnt
FROM step2
GROUP BY 
   sido,
   sigungu
ORDER BY 
   cnt DESC;
