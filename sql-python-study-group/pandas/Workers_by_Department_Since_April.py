# Grouped Aggregations
# Import your libraries
import pandas as pd

# Start writing code
result = (worker.query("joining_date >= '2014-04-01'")
                .groupby('department')['worker_id']
                .count()
                .reset_index(name='n_worker')
                .sort_values('n_worker', ascending=False))
