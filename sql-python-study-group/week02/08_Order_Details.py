# Import your libraries
import pandas as pd

# Start writing code
customers.head()

merged = customers.merge(orders, left_on='id', right_on='cust_id')

filtered = merged[merged['first_name'].isin(['Jill', 'Eva'])]

result = filtered[['first_name', 'order_date', 'order_details', 'total_order_cost']]
