# Import your libraries
import pandas as pd

# Step 1: 각 사용자별 총 이메일 전송 개수 계산
df = google_gmail_emails.rename(columns={'from_user': 'user_id'})
df = df.groupby('user_id')['id'].count().reset_index().rename(columns={'id': 'cnt'})

# Step 2: 활동 순위 계산 (중복 없이 고유값)
df['rn'] = df['cnt'].rank(method='first', ascending=False)

# Step 3: 정렬 (이메일 수 내림차순 → 순위 오름차순)
result = df.sort_values(by=['cnt', 'rn'], ascending=[False, True])

# Review Notes:
# 2025-11-15: 다시 풀어보기, 어려운 문제는 아닌데 엄청 헷갈림

