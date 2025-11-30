import numpy as np

def linear_regression_normal_equation(X: list[list[float]], y: list[float]) -> list[float]:
    # Python list → 넘파이 array 변환 필수: 행렬 연산 위해
    X = np.array(X)
    y = np.array(y).reshape(-1, 1)
    X_T = X.T
    # (XᵀX)⁻¹ Xᵀy 계산 — np.linalg.inv는 행렬의 역행렬을 구함
    theta = np.linalg.inv(X_T.dot(X)).dot(X_T).dot(y)
    # 다차원 배열을 1차원으로 펼침 -> numpy 배열을 파이썬 리스트로 변환
    theta = np.round(theta, 4).flatten().tolist()
    return theta
