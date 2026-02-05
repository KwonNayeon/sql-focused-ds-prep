# Grouped Aggregations
# Import your libraries
import pandas as pd

df = ms_employee_salary

df['rn'] = df.groupby('id')['salary'].rank(method='first', ascending=False)

result = df[df['rn']==1]

result = result.drop(columns=['rn'])
