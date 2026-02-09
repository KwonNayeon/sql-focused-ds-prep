# Grouped Aggregations
# Import your libraries
import pandas as pd

# Start writing code
df = facebook_complaints.copy()

# True/False를 1/0으로 자동 변환 -> 평균 계산 = 비율
result = df.groupby('type')['processed'].mean().reset_index()
