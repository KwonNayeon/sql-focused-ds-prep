'''
select
    to_char(shipment_date, 'YYYY-MM') as year_month,
    count(distinct(shipment_id, sub_id)) as n_shipment
from amazon_shipment
group by year_month
;
'''
# Import your libraries
import pandas as pd

df = amazon_shipment.copy()
df['year_month'] = df['shipment_date'].dt.strftime('%Y-%m')
df_unique = df.drop_duplicates(subset=['year_month', 'shipment_id', 'sub_id'])
result = df_unique.groupby('year_month').size().reset_index(name='n_shipment')
