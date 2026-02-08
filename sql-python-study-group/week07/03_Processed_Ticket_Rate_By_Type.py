# Processed Ticket Rate By Type
# Import your libraries
import pandas as pd
# Start writing code
df = facebook_complaints.copy()
# mean(): True=1, False=0으로 계산되어 평균 = 비율 (예: 3/5 = 0.6 = 60%)
df = df.groupby('type')['processed'].mean().reset_index(name='processed_rate')
