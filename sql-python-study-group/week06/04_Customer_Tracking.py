# Import your libraries
import pandas as pd

df = cust_tracking

# 정렬
df = df.sort_values(['cust_id', 'timestamp'])

# LEAD: shift(-1)
df['next_timestamp'] = df.groupby('cust_id')['timestamp'].shift(-1)
df['next_state'] = df.groupby('cust_id')['state'].shift(-1)

# state=1이고 next_state=0인 세션만 필터링
sessions = df[(df['state'] == 1) & (df['next_state'] == 0)]

# 시간 차이 계산 (시간 단위)
sessions['session_hours'] = (sessions['next_timestamp'] - sessions['timestamp']).dt.total_seconds() / 3600

# cust_id별 합계
result = sessions.groupby('cust_id')['session_hours'].sum().reset_index()
result

'''
Review Notes:
2025-12-12: 복습하기
'''
