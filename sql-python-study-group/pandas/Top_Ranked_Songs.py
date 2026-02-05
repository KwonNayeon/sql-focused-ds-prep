# Grouped Aggregations
# Import your libraries
import pandas as pd

df = spotify_worldwide_daily_song_ranking

df = df[df['position']==1]

result = (df.groupby('trackname')['position']
            .count()
            .reset_index(name='n_occurances')
            .sort_values('n_occurances', ascending=False))
