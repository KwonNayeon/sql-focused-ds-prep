# Income by Title and Gender

# Import your libraries
import pandas as pd

# Calculate total bonus per employee
bonus = sf_bonus.groupby('worker_ref_id')['bonus'].sum().reset_index(name='total_bonus')

# Join employee data with bonus data
merged = sf_employee.merge(bonus, left_on='id', right_on='worker_ref_id')

# Calculate total income (salary + bonus)
merged['total_income'] = merged['total_bonus'] + merged['salary']

# Calculate average total income by job title and gender
merged = merged.groupby(['employee_title', 'sex'])['total_income'].mean().reset_index(name='avg_income')

'''
Review Notes:
2025-11-28: avg()가 아니라 mean()을 써야 함
'''
