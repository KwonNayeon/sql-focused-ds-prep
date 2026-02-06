# Filtering & Sorting
# Import your libraries
import pandas as pd

# Start writing code
df = sat_scores.copy()

median_writing = df['sat_writing'].median()

result = df[df['sat_writing'] == median_writing]['student_id']
