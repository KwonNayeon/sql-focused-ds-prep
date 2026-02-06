# Top 10 Songs 2010
# Import your libraries
import pandas as pd

# Start writing code
df = billboard_top_100_year_end.copy()

df = df.query("year == 2010 and year_rank <= 10")

df = df.sort_values('year_rank')

result = df[['year_rank', 'group_name', 'song_name']].drop_duplicates()
