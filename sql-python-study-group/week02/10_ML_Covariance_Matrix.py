# 직접 구현
def calculate_covariance_matrix(vectors: list[list[float]]) -> list[list[float]]:
    # Define dimension variables - col, row
    n_features, n_obs = len(vectors), len(vectors[0])
    # Initialize our return: covariance matrix
    cov_matrix = [[0 for _ in range(n_features)] for _ in range(n_features)]
    # N*N
    # Pre-calculate means
    means = [sum(feature)/n_obs for feature in vectors]
    # Populate the return matrix
    # 상삼각행렬만 계산 (i <= j인 경우만)
    for i in range(n_features):
        for j in range(i, n_features):
            cov = sum(((vectors[i][k] - means[i])*(vectors[j][k] - means[j])) for k in range(n_obs))/(n_obs-1)
            cov_matrix[i][j] = cov
            cov_matrix[j][i] = cov

    return cov_matrix

# numpy 활용
import numpy as np

def calculate_covariance_matrix(vectors: list[list[float]]) -> list[list[float]]:
    return np.cov(vectors)
