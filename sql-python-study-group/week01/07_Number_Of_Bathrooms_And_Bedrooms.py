# Import your libraries
import pandas as pd

df = airbnb_search_details

# city, property_type별로 groupby -> bathrooms & bedrooms의 평균 구하기
df['n_bathrooms_avg'] = df.groupby(['city', 'property_type'])['bathrooms'].transform('mean')
df['n_bedrooms_avg'] = df.groupby(['city', 'property_type'])['bedrooms'].transform('mean')

# 중복 제거
result = df[['city', 'property_type', 'n_bathrooms_avg', 'n_bedrooms_avg']].drop_duplicates()

'''
Review Notes:
2025-11-06: 문제에서 요구하는 조건을 맞추기 위해 마지막에 중복을 제거해야 함
2025-11-10: 마지막에 중복 제거하는 것 잊지 말기
'''
