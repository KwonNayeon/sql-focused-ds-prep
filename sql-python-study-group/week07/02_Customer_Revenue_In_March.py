# Customer Revenue In March
# Import your libraries
import pandas as pd

df = orders.copy()

result = (df.query("order_date >= '2019-03-01' and order_date <= '2019-03-31'")
            .groupby('cust_id')['total_order_cost'].sum().reset_index(name='total_revenue')
            .sort_values('total_revenue', ascending=False))
