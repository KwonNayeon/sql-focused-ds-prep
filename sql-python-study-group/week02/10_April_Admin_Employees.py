# Import your libraries
import pandas as pd

# Start writing code
worker.head()

result = (worker.query("joining_date.dt.month >= 4 and department == 'Admin'")
                .groupby('department')['worker_id'].agg(n_workers='count'))
