# Import your libraries
import pandas as pd

# Find all Lyft drivers who earn either equal to
# or less than 30k USD or equal to or more than 70k USD.

result = lyft_drivers[(lyft_drivers['yearly_salary'] <= 30000) | (lyft_drivers['yearly_salary'] >= 70000)]

# Review Notes:
# 2025-11-12: OR 조건 필터링 배움
