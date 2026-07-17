select
    a.number as number_1,
    b.number as number_2,
    greatest(a.number, b.number) as max_number
from deloitte_numbers a
cross join deloitte_numbers b
;

-- cross join: 두 테이블의 모든 행 조합을 만듦(Cartesian product)
-- greatest: 한 행 안의 칼럼끼리 비교
