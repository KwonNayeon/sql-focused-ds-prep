# Import your libraries
import pandas as pd

# Merge worker and title tables (right join)
merged = worker.merge(title, left_on='worker_id', right_on='worker_ref_id', how='right')

# Rank by salary (dense rank, ties get same rank)
merged['rank'] = merged['salary'].rank(method='dense', ascending=False)

# Filter employees with highest salary (rank 1)
rank = merged[merged['rank'] == 1]

# Select job titles
result = rank[['worker_title']]
