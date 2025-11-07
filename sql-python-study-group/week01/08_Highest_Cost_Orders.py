# Import your libraries
import pandas as pd

# 1. merge: customers와 orders 조인
merged = customers.merge(orders, left_on='id', right_on='cust_id', how='left')

# 2. 날짜 필터링: 2019-02-01 ~ 2019-05-01
# 날짜 타입으로 변환 후 필터링
merged['order_date'] = pd.to_datetime(merged['order_date'])
filtered = merged[(merged['order_date'] >= '2019-02-01') & (merged['order_date'] < '2019-05-01')]
filtered.head()

# 3. groupby + sum: 고객별, 날짜별 합계
grouped = filtered.groupby(['first_name', 'order_date'], as_index=False)['total_order_cost'].sum()

# 4. rank: 날짜별로 합계 기준 순위 매기기
grouped['rn'] = grouped.groupby('order_date')['total_order_cost'].rank(method='min', ascending=False)

# 5. rn = 1만 필터링: 각 날짜별 최고액만
grouped = grouped[grouped['rn'] == 1]

# 6. 필요한 컬럼만 선택
result = grouped[['first_name', 'order_date', 'total_order_cost']]

'''
Review Notes:
2025-11-07: 조건에 맞게 필터링 하는 법 배움, 지금까지 문제 풀면서 썼던 거 다 응용하면 풀 수 있는 문제, 꼭 다시 풀어보기
'''
