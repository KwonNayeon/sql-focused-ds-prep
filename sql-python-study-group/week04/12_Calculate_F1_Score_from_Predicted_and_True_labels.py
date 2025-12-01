# Calculate F1 Score from Predicted and True labels
# Precision: 1로 예측한 것 중 진짜 1인 것의 비율, 분모 = positive로 예측
# Recall: 실제 1인 것 중 내가 맞게 예측한 비율, 분모 = 실제 positive

import numpy as np
def calculate_f1_score(y_true, y_pred):
    """
    Calculate the F1 score based on true and predicted labels.

    Args:
        y_true (list): True labels (ground truth).
        y_pred (list): Predicted labels.

    Returns:
        float: The F1 score rounded to three decimal places.
    """
    # Your code here
    y_true = np.array(y_true)
    y_pred = np.array(y_pred)

    true_positive = ((y_true == 1) & (y_pred == 1)).sum()
    all_positive = (y_true == 1).sum()
    pred_positive = (y_pred == 1).sum()

    if all_positive == 0 or pred_positive == 0:
        return 0.0

    precision = true_positive/pred_positive
    recall = true_positive/all_positive
    f1 = 2 * ((precision*recall)/(precision+recall))

    return round(f1,3)
