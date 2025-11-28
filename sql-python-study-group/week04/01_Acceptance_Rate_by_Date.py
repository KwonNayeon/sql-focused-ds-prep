# Acceptance Rate by Date

# Import your libraries
import pandas as pd

# Filter sent and accepted
sent = fb_friend_requests[fb_friend_requests['action'] == 'sent']
accepted = fb_friend_requests[fb_friend_requests['action'] == 'accepted']

# Left join
merged = sent.merge(accepted,
                    on=['user_id_sender', 'user_id_receiver'],
                    how='left',
                    suffixes=('_sent', '_accepted'))
                    
# Calculate counts by date
# count(): non-null 값만 카운트 (수락된 요청만)
# size(): 모든 행 카운트 (보낸 요청 전체)
result = merged.groupby('date_sent').agg(
    send_cnt=('user_id_sender', 'size'),
    receive_cnt=('date_accepted', 'count')  # count non-null values only
).reset_index()

# Calculate percentage
result['percentage_acceptance'] = result['receive_cnt'] / result['send_cnt']

result[['date_sent', 'percentage_acceptance']]
