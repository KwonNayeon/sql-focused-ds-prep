# Import your libraries
import pandas as pd

df = dc_bikeshare_q1_2012

# bike_number별로 groupby -> end_time으로 순위 매기기
df['rn'] = df.groupby('bike_number')['end_time'].rank(method='first', ascending=False)
df

# rn=1인 것들만 필터링
result = df[df['rn'] == 1]
result

# 필요한 칼럼만 선택 -> 가장 최근 날짜부터 정렬
result = result[['bike_number', 'end_time']].sort_values('end_time', ascending=False)
result

'''
Review Notes:
2025-11-05: 처음 풂
'''
