# String Manipulation
# Import your libraries
import pandas as pd

# Start writing code
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
        
df['popularity'] = df['number_of_reviews'].apply(popularity_func)

# .reset_index() 추가하면 popularity가 인덱스에서 일반 컬럼으로 변환됨
result = df.groupby('popularity')['price'].agg(['min', 'mean', 'max']).reset_index()
