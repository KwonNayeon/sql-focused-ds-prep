def linear_regression_gradient_descent(X: np.ndarray, y: np.ndarray, alpha: float, iterations: int) -> np.ndarray:
    """
    Perform linear regression using gradient descent.
    
    Advantages over Normal Equation:
    - Works well even when X.T @ X is not invertible (singular matrix)
    - More efficient for large datasets (avoids O(n^3) matrix inversion)
    - Can handle very large number of features (n > 10,000)
    - Iteratively minimizes the cost function (MSE loss)

    m = number of training examples
    n = number of parameters (features), technically n-1 features, 1st column is for intercept

    X: shape (m, n), `m` training examples with `n` input values for each feature
    y: shape (m, 1) array with the target values (ground truth)
    alpha: learning rate
    iterations: number of gradient descent steps
    """

    m, n = X.shape
    y = y.reshape(-1, 1)     # Make sure y is a column vector
    theta = np.zeros((n, 1))  # Initialize parameters to zero

    # Gradient Descent: iteratively update theta to minimize MSE loss
    # Cost function J(θ) = (1/2m) * Σ(h(x) - y)²
    for _ in range(iterations):
        predictions = X @ theta              # h(x) = X * theta
        errors = predictions - y.reshape(-1,1)  # (h(x) - y)
        updates = X.T @ errors / m           # Gradient: (1/m) * X.T * errors
        theta -= alpha * updates             # Update rule: θ := θ - α * gradient
    
    return np.round(theta.flatten(), 4)     # Rounded to 4 decimals
