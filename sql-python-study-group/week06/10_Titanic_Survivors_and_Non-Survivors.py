# Import your libraries
import pandas as pd

# size(): 결측치(NaN)를 포함해서 카운트
# fill_value=0: unstack할 때 결측치를 0으로 채움
result = titanic.groupby(['survived', 'pclass']).size().unstack(fill_value=0)
result.columns = ['first_class', 'second_classs', 'third_class']
result.reset_index()
