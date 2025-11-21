# Import your libraries
import pandas as pd

# Start writing code
df = forbes_global_2010_2014

df = (df.query("sector == 'Financials'")
        .nlargest(1, 'profits')
        .loc[:, ['continent', 'company']]
    )
