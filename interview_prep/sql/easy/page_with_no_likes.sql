-- ============================================================
-- [트러블슈팅 노트] Page With No Likes
-- Filename: page_with_no_likes.sql
-- 
-- [1] 목표:
--   - 좋아요를 하나도 받지 않은 Facebook 페이지의 ID를 찾기
--   - 결과를 페이지 ID 기준 오름차순 정렬
--
-- [2] 문제 해결 과정:
--   1. 초기 접근 오류:
--      - COUNT(*)를 사용하여 단순히 개수만 반환
--      - 개별 page_id가 아닌 총 개수만 조회되어 부적절함
--   
--   2. 올바른 해결:
--      - LEFT JOIN으로 pages 테이블의 모든 페이지 유지
--      - WHERE B.page_id IS NULL로 매칭되지 않는 페이지 필터링
--      - SELECT A.page_id로 해당 페이지들의 ID 반환
--
-- [3] 학습 포인트:
--   - LEFT JOIN: 첫 번째 테이블의 모든 행 보존
--   - IS NULL: JOIN 후 매칭되지 않는 행 찾기
--   - 문제 요구사항 정확한 파악의 중요성
-- ============================================================

SELECT 
    A.page_id
FROM pages A
LEFT JOIN page_likes B
    ON A.page_id = B.page_id
WHERE B.page_id IS NULL
ORDER BY A.page_id ASC;
