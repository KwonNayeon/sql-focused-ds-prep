# Import your libraries
import pandas as pd

# Start writing code
playbook_events.head()

# Step 1: Filter device = 'macbook pro'
# Step 2: Group by event_name and count user_id
# Step 3: Sort by count descending
df = (playbook_events[playbook_events["device"] == "macbook pro"]
      .groupby("event_name")["user_id"]
      .count()
      .reset_index(name='cnt')
      .sort_values("cnt", ascending=False))
