# Matching Similar Hosts and Guests

# Import your libraries
import pandas as pd

# Start writing code
merged = airbnb_hosts.merge(airbnb_guests, on=['nationality', 'gender'], how='inner')

# 처음에 drop_duplicates() 누락해서 틀림
result = merged[['host_id', 'guest_id']].drop_duplicates()
