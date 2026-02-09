# Top Percentile Fraud
# Import your libraries
import pandas as pd

# Start writing code
df = fraud_score.copy()


df['p95'] = df.groupby('state')['fraud_score'].transform(lambda x: x.quantile(0.95))

result = df.query("fraud_score >= p95").drop(columns='p95')
