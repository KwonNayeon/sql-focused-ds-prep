# Import your libraries
import pandas as pd

# Start writing code
df = fb_active_users.copy()

filtered = df.query("country == 'USA' and status == 'open'")

result = (len(filtered) / len(df)) * 100
