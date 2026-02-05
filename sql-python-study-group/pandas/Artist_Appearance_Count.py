# Grouped Aggregations
# Import your libraries
import pandas as pd

# Start writing code
df = spotify_worldwide_daily_song_ranking

result = (df.groupby('artist')['id']
            .count()
            .reset_index(name='n_occurrences')
            .sort_values('n_occurrences', ascending=False))
