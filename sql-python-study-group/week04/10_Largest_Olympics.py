# Largest Olympics

# Import your libraries
import pandas as pd

# Start writing code
df = olympics_athletes_events.groupby(['year', 'season', 'games'])['id'].nunique().reset_index(name='athletes_count')

df['rank'] = df['athletes_count'].rank(ascending=False, method='dense')

df[df['rank'] == 1][['games', 'athletes_count']]

# Review Notes:
# 2025-12-01: 고유값만 출력하기 위해서는 count()가 아니라 nunique()를 사용해야 함
