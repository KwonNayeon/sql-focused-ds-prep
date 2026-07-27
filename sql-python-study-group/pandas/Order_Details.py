# Joins & Merging
# Import your libraries
import pandas as pd

# Start writing code
customers.head()

merged = customers.merge(orders, left_on='id', right_on='cust_id')

result = merged[merged['first_name'].isin(['Jill', 'Eva'])][['first_name', 'order_date', 'order_details', 'total_order_cost']]

# Review Notes:
# 2026-07-27: 복습
