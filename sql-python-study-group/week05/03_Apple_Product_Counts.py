# Apple Product Counts

# Import your libraries
import pandas as pd

# merge
merged = playbook_events.merge(playbook_users, on='user_id', how='left')

# Is apple device?
apple_devices = ['macbook pro', 'iphone 5s', 'ipad air']

# apple device 사용하는 언어만 있음
df = (merged[merged['device'].isin(apple_devices)]
        .groupby('language')['user_id']
        .nunique()
        .to_frame('n_apple_users')
    )

# 모든 언어가 다 있음    
result = (merged.groupby('language')['user_id']
                .nunique()
                .rename('n_total_users')
                .reset_index()
    )

# result가 df보다 더 큰 집합이기 때문에 left join을 해도 괜찮음
result = (result.merge(df, how='left', on='language')
                .fillna(0)
                .sort_values('n_total_users', ascending=False)
                [['language', 'n_apple_users', 'n_total_users']]
         )

'''
Review Notes:
2025-12-05: 복습하기
'''
