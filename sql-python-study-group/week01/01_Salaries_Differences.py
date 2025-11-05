# Import your libraries
import pandas as pd
'''
1. JOIN → merge()
2. WHERE → boolean indexing []
3. GROUP BY + 집계 → groupby().agg()
4. CASE WHEN → pivot이나 조건부 추출
5. 최종 계산 → 산술 연산
'''
# 1. JOIN → merge()
merged = db_employee.merge(db_dept, left_on = 'department_id', right_on = 'id')

# 2. WHERE → boolean indexing [] - Pandas에서는 이 과정 필요 없음
# filtered = merged[merged['department'].isin(['engineering', 'marketing'])]

# 3. GROUP BY + 집계 → groupby().agg()
grouped = merged.groupby('department')['salary'].max()

# 4. CASE WHEN → pivot이나 조건부 추출
eng_max = grouped['engineering']
mkt_max = grouped['marketing']

# 5. 최종 계산 → 산술 연산
salary_difference = abs(eng_max - mkt_max)
salary_difference

# Review Notes:
# 2025-11-04: 처음 풂
# 2025-11-05: 문제를 작은 스텝으로 쪼개는 것까지 가능해짐, 아직 문법은 익숙하지 않음
