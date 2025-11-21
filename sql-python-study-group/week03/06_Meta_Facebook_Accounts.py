# Import your libraries
import pandas as pd

# 내 풀이
df = fb_account_status

df = df.query("status_date == '2020-01-10'")

closed = df[df['status'] == 'closed']['acc_id'].nunique()
total = df['acc_id'].nunique()
ratio = closed/total

# 개선된 버전 (✅ 복습하기)
df = fb_account_status.query("status_date == '2020-01-10'")
result = df[df['status'] == 'closed']['acc_id'].nunique() / df['acc_id'].nunique()
