# Import your libraries
import pandas as pd

# Merge employee and survey data
merged = facebook_employees.merge(facebook_hack_survey, left_on='id', right_on='employee_id', how='inner')

# Calculate average popularity per office location
result = (merged.groupby('location')['popularity']
          .mean()
          .reset_index()
          .rename(columns={'popularity': 'avg_popularity'}))

# Review Notes:
# 2025-11-12: transform -> drop_duplicate보다는 이 방법 사용하기
