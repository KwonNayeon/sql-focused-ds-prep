# Implement Recall Metric in Binary Classification

import numpy as np
def recall(y_true, y_pred):
    """
    1. true_positive → 실제 1이고 예측도 1인 경우 (TP)
    2. all_positive → 실제 1인 모든 경우 (TP + FN)
    3. TP / (TP + FN) → Recall
    """
    true_positive = ((y_true == 1) & (y_pred == 1)).sum()
    all_positive = (y_true == 1).sum()

    if all_positive == 0:
        return 0.0
        
    return round(true_positive / all_positive, 3)
