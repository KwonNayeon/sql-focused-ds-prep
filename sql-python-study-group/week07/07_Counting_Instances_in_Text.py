# Counting Instances in Text
# Import your libraries
import pandas as pd

# Start writing code
df = google_file_store.copy()

df['word'] = (df['contents'].str.lower()
                            .str.replace('.', '', regex=False)
                            .str.split(' '))
df = df.explode('word')

result = (df.groupby('word').size().reset_index(name='occurrences')
            .query("word in ('bull', 'bear')"))

# regex 파라미터:
# - regex=True (기본값): 첫 번째 인자를 정규식(regex)으로 해석
# - regex=False: 첫 번째 인자를 일반 문자열로 해석
