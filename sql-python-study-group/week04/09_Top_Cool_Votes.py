# Top Cool Votes

# Import your libraries
import pandas as pd

# Start writing code
df = yelp_reviews
df['rank'] = df['cool'].rank(ascending=False, method='dense')

df[df['rank'] == 1][['business_name', 'review_text']]
