-- Step 1: 각 사용자별 총 이메일 전송 개수 계산
-- Step 2: 사용자명, 총 이메일 수, 활동 순위 추출 (순위는 중복 없이 고유값)
-- Step 3: 정렬 조건
--   - 1차: 총 이메일 수 기준 내림차순
--   - 2차: 동일한 이메일 수를 가진 사용자는 이름 기준 오름차순
select
    from_user,
    count(from_user) as cnt,
    row_number() over (order by count(from_user) desc, from_user asc) as rn
from google_gmail_emails
group by from_user
order by count(from_user) desc
;

-- Review Notes:
-- 2025-11-15: order by 다중 정렬 조건 (복합 정렬)
