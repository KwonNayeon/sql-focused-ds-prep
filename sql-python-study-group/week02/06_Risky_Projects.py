# Import your libraries
import pandas as pd
import numpy as np

# 1. 테이블 merge (프로젝트, 직원-프로젝트 매핑, 직원 정보)
merged = (linkedin_projects
        .merge(linkedin_emp_projects, left_on='id', right_on='project_id', how='inner')
        .merge(linkedin_employees, left_on='emp_id', right_on='id', how='inner')
    )

# 2. 프로젝트별 일할 계산된 급여 계산
merged['salary_per_project'] = merged['salary'] * (merged['end_date'] - merged['start_date']).dt.days / 365

# 3. 프로젝트별 총 비용 집계 및 올림 처리
grouped = (merged.groupby(['project_id', 'title', 'budget'])['salary_per_project']
           .sum()
           .apply(np.ceil)
           .reset_index()
           .rename(columns={'salary_per_project': 'prorated_expense'})
          )

# 4. 예산 초과 프로젝트만 필터링
filtered = grouped[grouped['prorated_expense'] > grouped['budget']]

# 5. 결과 출력 (프로젝트명, 예산, 실제 비용)
result = filtered[['title', 'budget', 'prorated_expense']]

# Review Notes:
# 2025-11-17: 다시 풀어보기, 중간에 apply(np.ceil) 안 해서 틀렸음
