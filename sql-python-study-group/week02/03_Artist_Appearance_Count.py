# Import your libraries
import pandas as pd

# Start writing code
df = spotify_worldwide_daily_song_ranking

result = (df.groupby('artist')['id']
            .count()
            .reset_index()
            .rename(columns={'id': 'n_occurrences'})
            .sort_values('n_occurrences', ascending=False)
    )

# Review Notes:
# 2025-11-13: 코드 스타일 가독성있게 바꿔봄
