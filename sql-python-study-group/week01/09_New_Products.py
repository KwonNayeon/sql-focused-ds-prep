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
# pivot을 하면 특정 회사가 특정 연도에 제품을 출시하지 않은 경우 그 셀은 결측치로 남음 -> 결측치를 0으로 처리하여 계산 가능하도록
pivoted = grouped.pivot(index='company_name', columns='year', values='cnt').fillna(0)

# 3. 2020년과 2019년 차이 계산
# 마지막에 reset_index(drop=True)를 통해 인덱스 정리
result = pd.DataFrame({
    'company_name': pivoted.index,
    'net_difference': pivoted[2020] - pivoted[2019]
}).reset_index(drop=True)

'''
Review Notes:
2025-11-07: pivot 활용하는 법 배움. 꼭 다시 풀어보기
2025-11-10: 아직 pivot, dataframe 만드는 과정 헷갈림
'''
