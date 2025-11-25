# Import your libraries
import pandas as pd

# Start writing code
df = sf_restaurant_health_violations

# 1. street_name 컬럼 생성: 첫번째, 두번째 단어가 숫자인지 확인 후 street name 추출
df['street_name'] = df['business_address'].apply(
    lambda x: (
        x.split()[1].lower() if len(x.split()) > 1 and x.split()[0].isdigit()
        else x.split()[0].lower() if len(x.split()) > 1 and x.split()[1].isdigit()
        else x.split()[0].lower()
    ) if pd.notna(x) else None
)

# 2. business_postal_code가 null이 아닌 행만 필터링
df = df[df['business_postal_code'].notna()]

# 3. postal_code별 unique street name 개수 집계 및 정렬
result = (df.groupby('business_postal_code')['street_name']
    .nunique()
    .reset_index(name='n_streets')
    .sort_values(['n_streets', 'business_postal_code'], ascending=[False, True])
)

# Review Notes:
# 2025-11-25: 다시 풀어보기, 특히 첫 번째 단계는 꼭 다시 써보기
