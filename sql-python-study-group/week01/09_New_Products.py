'''
df.pivot(index='행으로_유지할_컬럼', 
         columns='컬럼으로_펼칠_값', 
         values='채워넣을_값')
'''
# Import your libraries
import pandas as pd

# 1. company_name과 year별로 제품 수 집계
df = car_launches
grouped = df.groupby(['company_name', 'year'])['product_name'].count().reset_index(name='cnt')

# 2. pivot: year를 컬럼으로 변환 (결측치는 0으로)
pivoted = grouped.pivot(index='company_name', columns='year', values='cnt').fillna(0)

# 3. 2020년과 2019년 차이 계산
result = pd.DataFrame({
    'company_name': pivoted.index,
    'net_difference': pivoted[2020] - pivoted[2019]
}).reset_index(drop=True)

'''
Review Notes:
2025-11-07: pivot 활용하는 법 배움. 꼭 다시 풀어보기
'''
