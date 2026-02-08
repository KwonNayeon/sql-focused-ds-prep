# Grouped Aggregations
# Import your libraries
import pandas as pd

df = airbnb_contacts.copy()

result = df.groupby('id_guest')['n_messages'].sum().reset_index(name='sum_messages')

result['rank'] = result['sum_messages'].rank(method='dense', ascending=False)

result
