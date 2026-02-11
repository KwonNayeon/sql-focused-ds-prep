# Grouped Aggregations
# Import your libraries
import pandas as pd

df = facebook_friends.copy()

df1 = df[['user1', 'user2']]
df2 = df[['user2', 'user1']].rename(columns={'user2': 'user1', 'user1': 'user2'})

users = pd.concat([df1, df2])

total_users = users['user1'].nunique()

result = (users.groupby('user1')
            .size()
            .reset_index(name='n_friends')
    )
    
result['popularity_percentage'] = result['n_friends'] / total_users * 100

result[['user1', 'popularity_percentage']].sort_values('user1', ascending=True)
