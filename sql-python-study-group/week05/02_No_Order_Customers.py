# No Order Customers

# Import your libraries
import pandas as pd

# Start writing code
customers.head()

orders_filtered = orders.query("order_date >= '2019-02-01' and order_date <= '2019-03-01'")

merged = customers.merge(orders_filtered, left_on='id', right_on='cust_id', how='left', suffixes=('_customer', '_order'))

result = merged.groupby(['id_customer', 'first_name'])['id_order'].count().reset_index(name='cnt')

result = result.query("cnt == 0")['first_name']
