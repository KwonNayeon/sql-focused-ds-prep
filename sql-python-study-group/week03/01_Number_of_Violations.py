# Import your libraries
import pandas as pd

# Start writing code
df = sf_restaurant_health_violations

# 내 풀이
df['inspection_date'] = pd.to_datetime(df['inspection_date'])
df['inspection_year'] = df['inspection_date'].dt.year

df = (df.query("violation_id.notna()")
        .query("business_name == 'Roxanne Cafe'")
        .groupby('inspection_year')['violation_id'].count().reset_index(name='n_violations')
        .loc[:, ['inspection_year', 'n_violations']]
    )

# 개선된 버전 (✅ 복습하기)
df = (df.dropna(subset=['violation_id'])  # query 대신
        .query('business_name == "Roxanne Cafe"')
        .assign(inspection_year=lambda x: pd.to_datetime(x['inspection_date']).dt.year)
        .groupby('inspection_year')['violation_id']
        .count()
        .reset_index(name='n_violations')
    )
