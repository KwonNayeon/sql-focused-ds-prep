# Import your libraries
import pandas as pd

# Start writing code
df = voting_results.copy()

df['n_votes'] = df.groupby('voter')['candidate'].transform('count')

df['vote_weight'] = 1.0 / df['n_votes']

result = (df.groupby('candidate')['vote_weight']
            .sum()
            .reset_index(name='total_votes')
            .sort_values('total_votes', ascending=False)
            .head(1)['candidate'])
