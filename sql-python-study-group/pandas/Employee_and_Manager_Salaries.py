import pandas as pd

df = employee.merge(employee, left_on='manager_id', right_on='id', suffixes=('_emp', '_mng'))

result = df.query("salary_emp > salary_mng")[['first_name_emp', 'salary_emp']]
