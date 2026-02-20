# Import your libraries
import pandas as pd

# Start writing code
df = airbnb_search_details.copy()

df['n_amenities'] = df['amenities'].str.strip('{}').str.split(',').str.len()

df['rank'] = df['n_amenities'].rank(method='dense', ascending=False)

df.query("rank == 1")['city']
