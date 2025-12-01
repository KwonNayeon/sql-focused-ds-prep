# Spam Posts

# Import your libraries
import pandas as pd

# 1. merge - 조회된 포스트만
merged = facebook_posts.merge(facebook_post_views, on='post_id', how='right')

# 2. spam 여부 판단
merged['is_spam'] = merged['post_keywords'].str.contains('spam', na=False)

# 3. 날짜별 group by
# - 전체 조회된 포스트 수 (view 기준) - count()
# - spam 조회 수 - sum()으로 True만 세기
all_cnt = merged.groupby('post_date')['is_spam'].count().reset_index(name='all_cnt')
spam_cnt = merged.groupby('post_date')['is_spam'].sum().reset_index(name='spam_cnt')

# 4. 날짜별 merge 후 spam 비율 계산 (spam views / total views * 100)
result = all_cnt.merge(spam_cnt, on='post_date')
result['spam_percentage'] = (result['spam_cnt'] / result['all_cnt']) * 100
result = result[['post_date', 'spam_percentage']]

# Review Notes:
# 2025-12-01: 다시 풀어보기
