import pandas as pd

df = (premium_accounts_by_day.query("final_price != 0").copy())
df['date_plus_7d'] = df['entry_date'] + pd.DateOffset(7)
df.head(5)

merged = pd.merge(
    df,
    df,
    how='left',
    left_on=['account_id', 'date_plus_7d'],
    right_on=['account_id', 'entry_date'],
    suffixes=('_left', '_right')
)

result = (
    merged.groupby('entry_date_left')
    .agg(
        # entry_date_left 기준으로 그날 paying한 고유 account 수
        # (left join 기준이므로 오늘 paying한 모든 account가 포함됨)
        premium_paid_accounts=('account_id', 'nunique'),
        
        # left join 후 entry_date_right가 NaN이 아닌 행만 카운트
        # = date_plus_7d(오늘+7일)에 같은 account_id가 존재했던 경우
        # = 7일 후에도 여전히 paying 중인 account 수
        premium_paid_accounts_after_7d=('entry_date_right', lambda x: x.notna().sum())
    )
    .reset_index()
    .rename(columns={'entry_date_left': 'entry_date'})
    .sort_values('entry_date')
    .head(7)
)
