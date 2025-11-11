# Import your libraries
import pandas as pd

df = facebook_web_log

# timestamp에서 day만 추출
df['day'] = df['timestamp'].dt.date

# page_load의 최대값 (가장 늦은 load)
last_load = (df[df['action'] == 'page_load'].groupby(['user_id', 'day'])['timestamp'].max().reset_index().rename(columns={'timestamp': 'last_load'}))

# page_exit의 최소값 (가장 빠른 exit)
first_exit = (df[df['action'] == 'page_exit'].groupby(['user_id', 'day'])['timestamp'].min().reset_index().rename(columns={'timestamp': 'first_exit'}))

# merge
merged = last_load.merge(first_exit, on=['user_id', 'day'])

# session time 계산 (load < exit만)
merged['session_time'] = merged['first_exit'] - merged['last_load']

# 유저별 평균
result = (merged.groupby('user_id')['session_time'].mean().reset_index().rename(columns={'session_time': 'avg_session_time'}))

'''
Review Notes:
2025-11-10: 내일 다시 풀어보자
2025-11-11: 어제보단 문법에 익숙해졌는데, 여전히 헷갈림
'''
