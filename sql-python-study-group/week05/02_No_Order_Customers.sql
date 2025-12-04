-- No Order Customers

-- left join으로 모든 customers 조회
-- between '2019-02-01' and '2019-03-01' 외의 주문은 모두 null로 표시
select
    c.first_name
from customers c
left join orders o on c.id = o.cust_id
and o.order_date between '2019-02-01' and '2019-03-01'
group by c.id, c.first_name
having count(o.id) = 0
;
