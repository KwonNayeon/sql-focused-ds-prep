# Import your libraries
import pandas as pd

# Merge customers and orders tables (left join)
merged = customers.merge(orders, left_on='id', right_on='cust_id', how='left')

# Sort by first_name and order_details (ascending)
merged = merged.sort_values(['first_name', 'order_details'], ascending=True)

# Select output columns
result = merged[['first_name', 'last_name', 'city', 'order_details']]
