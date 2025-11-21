-- Step 1: records on January 10th, 2020
-- Step 2: calculate the ratio of those with 'closed' status
select
    count(distinct case when status = 'closed' then acc_id end)*1.0 / count(distinct acc_id)*1.0 as closed_ratio
from fb_account_status
where status_date = '2020-01-10'

/*
헷갈렸던 것:
distinct: 한 계정이 각 날짜에 두 번 기록되는 경우 -> 비율 왜곡
count(distinct acc_id): count(*)를 하게 되면 행의 수를 반환, 우리가 알고 싶은 것은 acc_id의 수
1.0을 곱하는 이유: count()는 정수를 반환, 1.0을 곱하면 실수(decimal)반환

인터뷰에서 쓸 수 있는 영어표현:
"We need to multiply by 1.0 to convert the integer to a decimal."
→ 정수를 소수로 변환하기 위해 1.0을 곱해야 합니다.

"Without the decimal conversion, the result gets truncated."
→ 소수 변환 없이는 결과가 잘립니다.

"This gives us the ratio with decimal places."
→ 이렇게 하면 소수점 이하가 있는 비율을 얻습니다.

"The numerator is the count of closed accounts."
→ 분자는 닫힌 계정의 개수입니다.

"The denominator is the total number of accounts."
→ 분모는 전체 계정 수입니다.

"Integer division truncates the decimal places."
→ 정수 나눗셈은 소수점 이하를 버립니다.
*/
