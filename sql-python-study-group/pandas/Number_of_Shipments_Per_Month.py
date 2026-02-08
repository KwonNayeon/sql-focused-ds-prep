# Grouped Aggregations
import pandas as pd
df = amazon_shipment.copy()
df['year_month'] = df['shipment_date'].dt.strftime('%Y-%m')
# 같은 월에 같은 (shipment_id, sub_id) 조합은 1번만 세야함 <- (shipment_id, sub_id) = unique key
df = df.drop_duplicates(subset=['shipment_id', 'sub_id', 'year_month'])
# size(): 그룹당 전체 행 개수를 셈 (count()는 컬럼별 개수를 셈)
result = df.groupby('year_month').size().reset_index(name='n_shipment')
