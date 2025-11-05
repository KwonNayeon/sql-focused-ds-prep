# Import your libraries
import pandas as pd

# Start writing code
employee.head()

df = employee
df.head()

# dpt별로 group by -> 각 dpt별 avg를 나타내는 칼럼 생성
# transform으로 원본 df 길이에 맞춰 반환
df['avg_salary'] = df.groupby('department')['salary'].transform('mean')
df

# 필요한 칼럼만 추출
result = df[['department', 'first_name', 'salary', 'avg_salary']]
result

'''
Review Notes:
2025-11-05: transform 함수 배움
'''