# Import your libraries
import pandas as pd

# Start writing code
employee['highest_salary'] = employee.groupby('department')['salary'].transform('max')
employee.query("salary == highest_salary")[['department', 'first_name', 'highest_salary']]
