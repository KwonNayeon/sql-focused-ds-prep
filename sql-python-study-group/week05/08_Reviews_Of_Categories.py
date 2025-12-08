# Reviews of Categories

# Import your libraries
import pandas as pd

# 카테고리 분리
# 예시: 'Auto Detailing;Automotive' → ['Auto Detailing', 'Automotive'] → 2개 행으로 펼침
df = yelp_business.assign(
    categories=yelp_business['categories'].str.split(';')
    ).explode('categories')

# 그룹화 및 집계
result = df.groupby('categories')['review_count'].sum().reset_index(name='total_reviews')
result = result[['categories', 'total_reviews']].sort_values('total_reviews', ascending=False)
