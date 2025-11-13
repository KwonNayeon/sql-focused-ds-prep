# Import your libraries
import pandas as pd

# Start writing code
df = spotify_worldwide_daily_song_ranking

# position = 1만 필터링
top_1 = df[df['position'] == 1]

# group by -> count
result = (top_1.groupby('trackname')['position']
                .count()
                .reset_index()
                .rename(columns={'position': 'cnt'})
                .sort_values('cnt', ascending=False)
    )

# Review Notes:
# 2025-11-13: 귀찮더라도 문제 풀 때 스텝을 미리 적어두는 습관 만들기
