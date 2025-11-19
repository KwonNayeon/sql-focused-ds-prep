# 거의 처음부터 구현
import numpy as np

def k_fold_cross_validation(X: np.ndarray, y: np.ndarray, k=5, shuffle=True):
    """
    Implement k-fold cross-validation by returning train-test indices.
    """
    np.random.seed(42)
    n_samples = len(X)
    # 데이터 자체가 아닌 인덱스를 생성 [0, 1, 2, ..., n-1]
    indices = np.arange(n_samples)

    if shuffle:
        np.random.shuffle(indices)
    
    # 각 fold 크기 계산
    fold_sizes = np.full(k, n_samples // k, dtype=int)
    # 나머지는 앞쪽 fold에 분배
    fold_sizes[:n_samples % k] += 1

    # 인덱스를 fold별로 나누기
    current = 0
    folds = []
    for fold_size in fold_sizes:
        folds.append(indices[current:current+fold_size])
        current += fold_size

    # Train/Test split 생성
    result = []
    for i in range(k):
        test_idx = folds[i]
        # concatenate: 여러 배열을 하나로 합침 (i번째 fold 제외)
        train_idx = np.concatenate(folds[:i] + folds[i+1:])
        result.append((train_idx.tolist(), test_idx.tolist()))
    
    return result

# sklearn 활용
from sklearn.model_selection import KFold

kf = KFold(n_splits=5, shuffle=True, random_state=42)

for train_idx, test_idx in kf.split(X):
    X_train, X_test = X[train_idx], X[test_idx]
    y_train, y_test = y[train_idx], y[test_idx]
