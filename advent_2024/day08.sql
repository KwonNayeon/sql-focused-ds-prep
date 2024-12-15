-- 핵심 기능:
-- 1. 주문 데이터를 월 단위로 집계 (YYYY-MM 형식)
-- 2. 정상 주문 금액: 주문 ID가 'C'로 시작하지 않는 경우
-- 3. 취소 주문 금액: 주문 ID가 'C'로 시작하는 경우
-- 4. 전체 주문 금액 합계: 정상 주문 + 취소 주문 포함

select 
    strftime('%Y-%m', A.order_date) as order_month, -- 주문 날짜를 YYYY-MM 형식으로 변환
    sum(case when A.order_id not like 'C%' then B.price * B.quantity else 0 end) as ordered_amount, -- 정상 주문 금액
    sum(case when A.order_id like 'C%' then -B.price * B.quantity else 0 end) * -1 as canceled_amount, -- 취소 주문 금액 (양수로 표시)
    sum(B.price * B.quantity) as total_amount -- 전체 주문 금액 합계
from 
    orders A
left join 
    order_items B
on 
    A.order_id = B.order_id -- 주문과 주문 아이템 연결
group by 
    strftime('%Y-%m', A.order_date) -- 월 단위로 그룹핑
order by 
    order_month; -- 월별 정렬
