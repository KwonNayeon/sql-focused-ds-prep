# Import your libraries
import pandas as pd

result = (worker.query("joining_date >= '2014-04-01'")
                .groupby('department')['worker_id']
                .agg(n_workers='count')
                .reset_index()
                .sort_values('n_workers', ascending=False))
