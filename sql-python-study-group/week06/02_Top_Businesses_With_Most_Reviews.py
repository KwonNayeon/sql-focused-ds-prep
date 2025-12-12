# Import your libraries
import pandas as pd

df = yelp_business

df['review_rn'] = df['review_count'].rank(method='first', ascending=False)

result = df.query('review_rn < 6')[['name', 'review_count']].sort_values('review_count', ascending=False)
