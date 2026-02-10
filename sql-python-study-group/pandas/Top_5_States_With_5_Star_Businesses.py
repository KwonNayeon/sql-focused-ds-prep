# Window Functions
# Import your libraries
import pandas as pd

# Start writing code
df = yelp_business.copy()

df = (df.query("stars == 5")
        .groupby('state')['business_id'].count().reset_index(name='n_businesses'))
        
df['rank'] = df['n_businesses'].rank(method='dense', ascending=False)

result = (df.query("rank <= 5")
            .sort_values('rank', ascending=True))[['state', 'n_businesses']]
