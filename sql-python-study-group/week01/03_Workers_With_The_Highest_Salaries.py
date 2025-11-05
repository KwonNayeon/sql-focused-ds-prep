'''
# 1. 'min' - 동점자들 모두 같은 순위 (SQL의 RANK와 동일)
merged['rn'] = merged.groupby('worker_title')['salary'].rank(method='min', ascending=False)
# salary: 100, 100, 90 → rank: 1, 1, 3

# 2. 'dense_rank' - 동점자 같은 순위, 다음 순위 연속 (SQL의 DENSE_RANK)
merged['rn'] = merged.groupby('worker_title')['salary'].rank(method='dense', ascending=False)
# salary: 100, 100, 90 → rank: 1, 1, 2

# 3. 'first' - 동점자도 순서대로 (SQL의 ROW_NUMBER)
merged['rn'] = merged.groupby('worker_title')['salary'].rank(method='first', ascending=False)
# salary: 100, 100, 90 → rank: 1, 2, 3
'''
# Import your libraries
import pandas as pd

# 1. worker와 title 테이블 merge
merged = worker.merge(title, left_on='worker_id', right_on='worker_ref_id')

# 2. 각 job title별로 salary 순위 매기기
merged['rn'] = merged.groupby('worker_title')['salary'].rank(method='min', ascending=False)

# 3. 각 job title에서 1위만 추출 (동점 포함)
merged = merged[merged['rn'] == 1]

# 4. 전체에서 salary가 최대인 행만 추출
max_salary = merged['salary'].max()
result = merged[merged['salary'] == max_salary]

# 5. 최종 결과: job title만 추출
best_paid_title = result['worker_title']

'''
Review Notes:
2025-11-05: 처음 풂, 위의 문제들과 비슷해서 쉬울줄 알았는데, 생각보다 쉽지 않았다.
'''
