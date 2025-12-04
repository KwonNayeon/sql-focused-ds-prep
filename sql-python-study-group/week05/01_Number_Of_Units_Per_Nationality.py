# Number Of Units Per Nationality

# Import your libraries
import pandas as pd

# merge
merged = airbnb_hosts.merge(airbnb_units, on='host_id', how='inner')

# filtering
filtered = merged[(merged['age'] < 30) & (merged['unit_type'] == 'Apartment')]

# groupby -> distinct값 추출
result = filtered.groupby('nationality')['unit_id'].nunique().reset_index(name='n_unit')

# result
result = result.nlargest(1, 'n_unit', keep='all')[['nationality', 'n_unit']]
