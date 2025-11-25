# Import your libraries
import pandas as pd

# 내 풀이
df = amazon_transactions

df['day'] = df['created_at'].dt.day

df = df.sort_values(['user_id', 'day'])

df['previous_day'] = df.groupby('user_id')['day'].shift(1)

df = df.query("1 <= day - previous_day <= 7")

df['user_id'].unique()

# 개선된 버전 (✅ 복습하기)
result = (amazon_transactions
    .assign(day=lambda x: x['created_at'].dt.day)
    .sort_values(['user_id', 'day'])
    .assign(previous_day=lambda x: x.groupby('user_id')['day'].shift(1))
    .query("1 <= day - previous_day <= 7")
    ['user_id']
    .unique()
)
