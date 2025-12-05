# Rank Variance Per Country

# Import your libraries
import pandas as pd

merged = fb_comments_count.merge(fb_active_users, on='user_id', how='inner')

merged['created_at']

dec_comments = (merged[(merged['created_at'] >= '2019-12-01') & (merged['created_at'] < '2020-01-01')]
                .groupby('country')['number_of_comments']
                .sum()
                .reset_index(name='dec_comments'))

jan_comments = (merged[(merged['created_at'] >= '2020-01-01') & (merged['created_at'] < '2020-02-01')]
                .groupby('country')['number_of_comments']
                .sum()
                .reset_index(name='jan_comments'))

monthly = dec_comments.merge(jan_comments, on='country', how='outer').fillna(0)

monthly['dec_rank'] = monthly['dec_comments'].rank(method='dense', ascending=False)
monthly['jan_rank'] = monthly['jan_comments'].rank(method='dense', ascending=False)

result = monthly[monthly['dec_rank'] > monthly['jan_rank']]['country']
