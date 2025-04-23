"""
- Problem: Fibonacci Number
  - Input: An integer n (0 <= n <= 30)
  - Output: The nth Fibonacci number
  - Constraints: Use efficient computation for larger values of n (e.g., n = 30)

- Approach:
  1. Recursive (not recommended for large n due to exponential time)
  2. Iterative (uses loop and two variables, O(1) space)
  3. Dynamic Programming (stores intermediate results in an array)

- DP Explanation:
  - We use a bottom-up approach to fill a dp array where:
    - dp[0] = 0
    - dp[1] = 1
    - dp[i] = dp[i-1] + dp[i-2] for i >= 2

- Time/Space Complexity:
  - Time Complexity: O(n) – we calculate each value from dp[2] to dp[n] once
  - Space Complexity: O(n) – we store all Fibonacci numbers up to n in a list

- Edge Cases:
  - n = 0 → return 0
  - n = 1 → return 1
"""

# Recursive
def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)


# Iterative
def fibonacci(n: int) -> int:
    if n == 0:
        return 0
    a, b = 0, 1
    for _ in range(1, n):
        a, b = b, a + b
    return b


# Dynamic Programming
# dp[i] = i번째 달에 태어난 토끼 쌍의 수
def fib(n: int) -> int:
    if n <= 1:               # Base case
        return n

    dp = [0] * (n+1)         # DP 배열 초기화 (0부터 n까지니까 n+1개)
    dp[1] = 1                # 초기값 설정 (fib(0) = 0, fib(1) = 1)

    for i in range(2, n+1):  # 점화식 적용
        dp[i] = dp[i-1] + dp[i-2]

    return dp[n]             # 결과 리턴
