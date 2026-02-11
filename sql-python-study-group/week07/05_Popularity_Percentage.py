# Popularity Percentage
# Import your libraries
import pandas as pd

# Start writing code
df = facebook_friends.copy()

df1 = df[['user1', 'user2']]
df2 = df[['user2', 'user1']].rename(columns={'user2': 'user1', 'user1': 'user2'})

# union
users = pd.concat([df1, df2]).drop_duplicates()

total_users = users['user1'].nunique()

result = (users.groupby('user1')
                .size()
                .reset_index(name='friend_count'))
                
result['popularity_percent'] = (result['friend_count'] / total_users) * 100

result[['user1', 'popularity_percent']]
