-- 순매출은 반품되지 않은 거래 내역에 대해 주문 금액에서 할인 금액을 제외한 실제 결제 금액의 합을 의미
select
  extract(year from purchased_at) as year,
  sum(total_price-discount_amount) as net_sales
from transactions
where is_returned = 0
group by extract(year from purchased_at)
order by year asc
;
