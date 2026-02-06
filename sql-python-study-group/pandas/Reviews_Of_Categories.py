# String Manipulation
# Import your libraries
import pandas as pd
df = yelp_business.copy()

# Split categories string into list (like string_to_array in SQL)
df['categories'] = df['categories'].str.split(';')

# Explode list into separate rows (like unnest in SQL)
df = df.explode('categories')

# Sum total reviews per category and sort by review count
# count(): 몇 개의 business가 있는지 세는 것
# sum(): 각 business의 review_count 합
result = df.groupby('categories')['review_count'].sum().reset_index().sort_values('review_count', ascending=False)
