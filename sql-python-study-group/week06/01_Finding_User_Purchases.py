# Import your libraries
import pandas as pd

# Start writing code
df = amazon_transactions.sort_values(['user_id', 'created_at'])

df['previous_order'] = df.groupby('user_id')['created_at'].shift(1)

df['order_number'] = df.groupby('user_id')['created_at'].rank(method='first')

df['days_diff'] = (df['created_at'] - df['previous_order']).dt.days

filtered = df.query('previous_order.notna() and order_number == 2 and 0 < days_diff < 8')

filtered['user_id'].unique()
