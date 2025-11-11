-- 문제 풀 때 탭, 쉬프트+탭 적절히 활용하기
select
    dl.date,
    sum(case when ac.paying_customer = 'no' then dl.downloads end) as no_paying,
    sum(case when ac.paying_customer = 'yes' then dl.downloads end) as yes_paying
from ms_user_dimension us
left join ms_acc_dimension ac on us.acc_id = ac.acc_id
left join ms_download_facts dl on us.user_id = dl.user_id
group by dl.date
having sum(case when ac.paying_customer = 'no' then dl.downloads end) > sum(case when ac.paying_customer = 'yes' then dl.downloads end)
order by dl.date
;

-- Review Notes:
-- 2025-11-11: 제니님과 인터뷰 스터디에서 같이 푼 문제, 문제 풀 때 탭, 쉬프트+탭 활용하는 법 배움!
