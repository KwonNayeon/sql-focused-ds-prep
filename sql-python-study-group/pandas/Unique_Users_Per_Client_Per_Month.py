# Grouped Aggregations
# Import your libraries
import pandas as pd

df = fact_events.copy()

df['month'] = df['time_id'].dt.month

result = df.groupby(['client_id', 'month'])['user_id'].nunique().reset_index(name='n_unique_users')
