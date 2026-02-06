# Host Popularity Rental Prices
import pandas as pd

df = airbnb_host_searches

def popularity_func(x):
    if x == 0:
        return 'New'
    elif x <= 5:
        return 'Rising'
    elif x <= 15:
        return 'Trending Up'
    elif x <= 40:
        return 'Popular'
    else:
        return 'Hot'
        
df['popularity_rating'] = df['number_of_reviews'].apply(popularity_func)

result = df.groupby('popularity_rating')['price'].agg(['min', 'mean', 'max']).reset_index(names='popularity_rating')
