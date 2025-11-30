# Calculate Accuracy Score

import numpy as np

def accuracy_score(y_true, y_pred):
    """
    1. y_true == y_pred → boolean 배열 생성
    2. .sum() → True(맞은 것) 개수 계산
    3. len(y_true) → 전체 예측 개수
    4. 맞은 개수 / 전체 개수 → accuracy
    """
    n = len(y_pred)
    n_true = (y_true == y_pred).sum()
    return n_true / n
