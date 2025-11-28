# Highest Target Under Manager

# Import your libraries
import pandas as pd

df = salesforce_employees

# rank() 옵션: method='dense' 사용 (동점: 1, 1, 2, 3...)
df['rn'] = df.groupby('manager_id')['target'].rank(method='dense', ascending=False)

# 필터링: manager_id와 rn 조건을 동시에 적용 (&)
result = df[(df['manager_id'] == 13) & (df['rn'] == 1)][['first_name', 'target']]

'''
Review Notes:
2025-11-28: rank 옵션 외워두기
'''
