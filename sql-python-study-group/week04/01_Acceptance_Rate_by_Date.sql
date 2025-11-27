-- Acceptance Rate by Date
-- 각 날짜에 sent된 요청 수 계산
-- 그 요청이 accepted된 수 계산 (날짜 상관없이)

-- Step 1: sent된 요청들을 추출 (날짜, sender, receiver)
with sent as (
    select
        date,
        user_id_sender,
        user_id_receiver
    from fb_friend_requests
    where action = 'sent'
),
-- Step 2: accepted된 요청들을 추출 (sender, receiver만 - 날짜 무관)
accepted as (
    select
        user_id_sender,
        user_id_receiver
    from fb_friend_requests
    where action = 'accepted'
)
-- Step 3: sent 기준으로 LEFT JOIN하여 매칭
-- Step 4: sent 날짜별로 그룹화하여 acceptance rate 계산
select
    s.date,
    -- accepted된 요청 수 / 전체 sent 요청 수
    -- count(a.user_id_receiver): accepted와 매칭된 것만 카운트
    -- count(s.user_id_sender): 모든 sent 요청 카운트
    count(a.user_id_receiver) * 1.0 / count(s.user_id_sender) as percentage_acceptance
from sent s
left join accepted a 
    on s.user_id_sender = a.user_id_sender
    and s.user_id_receiver = a.user_id_receiver
group by s.dateRetryClaude can make mistakes. Please double-check responses.
