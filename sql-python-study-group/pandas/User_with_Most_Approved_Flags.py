# Import your libraries
import pandas as pd

# Start writing code
merged = user_flags.merge(flag_review, on='flag_id', how='inner')

merged['user_fullname'] = merged['user_firstname'] + ' ' + merged['user_lastname']

result = (merged.query("reviewed_outcome == 'APPROVED'")
                .groupby('user_fullname')['video_id']
                .nunique()
                .reset_index())
result
                
result['rk'] = result['video_id'].rank(method='dense', ascending=False)

result = result.query("rk == 1")['user_fullname']

# 문제 핵심:
# "flagged the most distinct videos that ended up APPROVED"
# → 승인된 영상 중 몇 개의 distinct video를 flag 했는지를 조회하는 문제

# video_id를 써야 하는 이유:
# 같은 video를 여러 번 flag 했을 수 있음
# → nunique()로 distinct video 수 카운트
