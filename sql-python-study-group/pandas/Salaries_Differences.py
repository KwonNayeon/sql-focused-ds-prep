# Joins & Merging
# Import your libraries
import pandas as pd

merged = db_employee.merge(db_dept, left_on='department_id', right_on='id')

salary = merged.groupby('department')['salary'].max()

eng_max = salary['engineering'].max()
mar_max = salary['marketing'].max()

abs_diff = abs(eng_max - mar_max)
