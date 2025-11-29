# Consecutive Days

# Import your libraries
import pandas as pd

df = sf_events

# Sort values
df = df.sort_values(['user_id', 'record_date'])

# lag, lead
# shift(1) = 이전 행의 값을 가져옴 = previous (lag)
# shift(-1) = 다음 행의 값을 가져옴 = next (lead)
df['previous_day'] = df.groupby('user_id')['record_date'].shift(1)
df['next_day'] = df.groupby('user_id')['record_date'].shift(-1)

# filtering
result = df[
    ((df['record_date'] - df['previous_day']).dt.days == 1)
    & ((df['next_day'] - df['record_date']).dt.days == 1)
    ]

# user_id만 추출
answer = result['user_id'].unique()

'''
Review Notes:
2025-11-29: filtering 할 때 헷갈림...
'''
