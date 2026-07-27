# Import your libraries
import pandas as pd

# Start writing code
df = los_angeles_restaurant_health_inspections

df = (df.query('score < 95')
        .query("facility_name == 'STREET CHURROS'")
        .loc[:, ['activity_date', 'pe_description']]
    )

# Review Notes:
# 2026-07-27: 복습
