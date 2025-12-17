# Import your libraries
import pandas as pd

# Start writing code
df = employee

df['rank'] = df['salary'].rank(ascending=False, method='first')

df[df['rank'] == 2][['salary']]
