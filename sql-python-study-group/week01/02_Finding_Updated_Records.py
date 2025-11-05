# Import your libraries
import pandas as pd
'''
1. 데이터 가져오기
2. 각 직원(id)별로 salary 순위 매기기 (윈도우 함수)
3. 순위 1번만 필터링
4. 필요한 컬럼만 선택
'''
# 데이터 가져오기
df = ms_employee_salary

# 각 직원(id)별로 salary 순위 매기기 (윈도우 함수)
# → groupby + rank 또는 sort_values + drop_duplicates
df['rn'] = df.groupby('id')['salary'].rank(method='first', ascending=False)

# 순위 1번만 필터링
result = df[df['rn'] == 1]

# 필요한 컬럼만 선택
result = result.drop(columns=['rn'])

# Review Notes:
# 2025-11-04: 처음 풂
# 2025-11-05: 문법은 여전히 헷갈림
