# Import your libraries
import pandas as pd

merged = employee.merge(employee, left_on='manager_id', right_on='id', suffixes=('_emp', '_mgr'))

merged.query("salary_emp > salary_mgr")[['first_name_emp', 'salary_emp']]
