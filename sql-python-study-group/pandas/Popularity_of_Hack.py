# Joins & Merging
import pandas as pd

merged = facebook_employees.merge(facebook_hack_survey, left_on='id', right_on='employee_id', how='inner')

merged = merged.groupby('location')['popularity'].mean().reset_index(name='popularity_avg')
