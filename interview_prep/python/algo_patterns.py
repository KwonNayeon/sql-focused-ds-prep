# Python Coding Patterns Part 1

# 1. Two Sum (Hash Map)
def two_sum(nums: list[int], target: int) -> list[int]:
    seen = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    return []  # base case: no valid pair found

def two_sum(nums: list[int], target: int):
    seen = {}

    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]    # 인덱스를 반환하는 것
        else:
            seen[num] = i
    return []


# 2. Reverse String (Two-Pointer)
def reverse_string(s: str) -> str:
    s = list(s)
    left, right = 0, len(s) - 1
    while left < right:
        s[left], s[right] = s[right], s[left]
        left += 1
        right -= 1
    return ''.join(s)   # 문자 리스트 -> 다시 문자열로


# 3. Palindrome Check
def is_palindrome(s: str) -> bool:
    return s == s[::-1]

def is_palindrome(s1):
    if s1.lower() == s1[::-1].lower():
        return True
    return False


# 4. Remove Duplicates (Keep Order)
def remove_duplicates(nums: list[int]) -> list[int]:
    seen = set()
    result = []
    for num in nums:
        if num not in seen:
            seen.add(num)
            result.append(num)
    return result


# 5. Factorial (Recursive)
def factorial(n: int) -> int:
    if n <= 1:
        return 1
    return n * factorial(n - 1)


# 6. Fibonacci (Memoization)
def fib(n: int, memo={}) -> int:
    if n <= 1:
        return n
    if n not in memo:
        memo[n] = fib(n-1, memo) + fib(n-2, memo)
    return memo[n]

# 6. Fibonacci (DP)
def fib(n: int) -> int:
    if n <= 1:               # Base case
        return n

    dp = [0] * (n+1)         # DP 배열 초기화 (0부터 n까지니까 n+1개)
    dp[1] = 1                # 초기값 설정 (fib(0) = 0, fib(1) = 1)

    for i in range(2, n+1):  # 점화식 적용
        dp[i] = dp[i-1] + dp[i-2]

    return dp[n]             # 결과 리턴


# 7. Binary Search (Iterative)
def binary_search(arr: list[int], target: int) -> int:
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1

def binary_search(arr: list[int], target: int):
    left, right = 0, len(arr) - 1

    while left <= right:    # 타겟이 마지막 요소인 경우도 고려하기 위하여
        mid = (left + right) // 2

        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1

        else:
            right = mid - 1

    return -1
