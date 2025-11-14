# Import your libraries
import pandas as pd

# 1. 세 테이블 merge
merged = (ms_user_dimension
        .merge(ms_acc_dimension, on='acc_id', how='left')
        .merge(ms_download_facts, on='user_id', how='left')
        )

# 2. pivot_table로 집계
pivoted = merged.pivot_table(
    index='date',
    columns='paying_customer',
    values='downloads',
    aggfunc='sum'
    ).reset_index()
    
# 3. 칼럼명 정리
pivoted.columns.name = None
pivoted = pivoted.rename(columns={'no': 'non_paying', 'yes': 'paying'})

# 4. 필터링 및 정렬
result = pivoted[pivoted['non_paying'] > pivoted['paying']]

# Review Notes:
# 2025-11-14: pivot_table 함수 사용법 익히기
