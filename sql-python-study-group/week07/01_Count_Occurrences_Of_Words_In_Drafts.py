# Count Occurrences Of Words In Drafts
# Import your libraries
import pandas as pd

df = google_file_store.copy()

# string to array
df['word'] = (df['contents'].str.lower()
                            .str.replace('.', '', regex=False)
                            .str.replace(',', '', regex=False)
                            .str.split(' ')
            )
# unnest
df = df.explode('word')

result = df.groupby('word').size().reset_index(name='occurrences')
