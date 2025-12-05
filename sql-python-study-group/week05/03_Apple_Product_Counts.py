# Apple Product Counts

# Import your libraries
import pandas as pd

# merge
merged = playbook_events.merge(playbook_users, on='user_id', how='left')

# Is apple device?
apple_devices = ['macbook pro', 'iphone 5s', 'ipad air']

df = (merged[merged['device'].isin(apple_devices)]
        .groupby('language')['user_id']
        .nunique()
        .to_frame('n_apple_users')
    )
    
result = (merged.groupby('language')['user_id']
                .nunique()
                .rename('n_total_users')
                .reset_index()
    )
    
result = (result.merge(df, how='outer', on='language')
                .fillna(0)
                [['language', 'n_apple_users', 'n_total_users']]
         )

'''
Review Notes:
2025-12-05: 복습하기
'''
