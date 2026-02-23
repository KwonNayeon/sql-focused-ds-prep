# 이름 파생변수 만드는 법 복습
# Import your libraries
import pandas as pd

# Start writing code
df = user_flags.copy()

# user_firstname, user_lastname 컬럼에 NaN이 있는 경우 처리
df['full_name'] = df['user_firstname'].fillna('') + ' ' + df['user_lastname'].fillna('')

df.head()

result = (df.query("flag_id == flag_id")
            .groupby('video_id')['full_name']
            .nunique()
            .reset_index(name='num_unique_users'))
