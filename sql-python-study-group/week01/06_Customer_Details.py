'''
SQL vs Pandas Merge

SQL              | Pandas
-----------------|-----------------
INNER JOIN       | how='inner' (기본값)
LEFT JOIN        | how='left'
RIGHT JOIN       | how='right'
FULL OUTER JOIN  | how='outer'
'''
# Import your libraries
import pandas as pd

# customers, orders 테이블 병합
merged = customers.merge(orders, left_on='id', right_on='cust_id', how='left')
merged.head()

# 고객의 first name, order details별로 정렬 (ascending order)
sorted = merged.sort_values(['first_name', 'order_details'], ascending=[True, True])

# 필요한 칼럼들만 추출
result = sorted[['first_name', 'last_name', 'city', 'order_details']]

'''
Review Notes:
2025-11-06: merge할 때 쓰이는 여러가지 옵션들 배움
2025-11-10: 마지막에 정렬하는 것 잊지 말기
'''
