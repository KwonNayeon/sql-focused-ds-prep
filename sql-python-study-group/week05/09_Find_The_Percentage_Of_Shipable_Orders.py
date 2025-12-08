# Find the percentage of shipable orders

# Import your libraries
import pandas as pd

merged = orders.merge(customers, left_on='cust_id', right_on='id', how='inner')

result = merged['address'].notnull().mean() * 100
