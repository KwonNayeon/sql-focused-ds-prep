# Import your libraries
import pandas as pd

# Start writing code
df = user_flags.copy()

df['user_fullname'] = df['user_firstname'].fillna('') + ' ' + df['user_lastname']

result = (df.query("flag_id == flag_id")
            .groupby('video_id')['user_fullname']
            .nunique()
            .reset_index(name='num_unique_users'))
