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

# Start writing code
customers.head()

# merge
merged = customers.merge(orders, left_on='id', right_on='cust_id', how='left')
merged.head()

# Sort records based on the customer's first name and the order details in ascending order.
sorted = merged.sort_values(['first_name', 'order_details'], ascending=[True, True])

# 최종 결과 추출
result = sorted[['first_name', 'last_name', 'city', 'order_details']]

'''
Review Notes:
2025-11-06: merge할 때 쓰이는 여러가지 옵션들 배움
'''
