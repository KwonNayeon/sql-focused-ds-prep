# Python Coding Patterns Part 1

# 1. Two Sum (Hash Map) - e.g., LeetCode 1: Two Sum
def two_sum(nums: list[int], target: int) -> list[int]:
    """
    Find indices of two numbers that add up to the target.
    Time Complexity: O(n) where n is the length of the array
    Space Complexity: O(n) for the hash map
    """
    seen = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]    # 인덱스를 반환하는 것
        else:
            seen[num] = i
    return []  # base case: no valid pair found

# 2. Reverse String (Two-Pointer) - e.g., LeetCode 344: Reverse String
def reverse_string(s: str) -> str:
    """
    Reverse a string using two pointers.
    Time Complexity: O(n) where n is the length of the string
    Space Complexity: O(n) for creating the list of characters
    """
    s = list(s)
    left, right = 0, len(s) - 1
    while left < right:
        s[left], s[right] = s[right], s[left]
        left += 1
        right -= 1
    return ''.join(s)   # 문자 리스트 -> 다시 문자열로

# Reverse Array (e.g., In-place Reverse - Two-pointer)
def reverse_array(arr: list[int]) -> list[int]:
    """
    Reverse an array in-place using two pointers.
    Time Complexity: O(n) where n is the length of the array
    Space Complexity: O(1) as it's done in-place
    """
    left, right = 0, len(arr) - 1
    while left < right:
        arr[left], arr[right] = arr[right], arr[left]
        left += 1
        right -= 1
    return arr

# 3. Palindrome Check - e.g., LeetCode 125: Valid Palindrome
def is_palindrome(s: str) -> bool:
    """
    Check if a string is a palindrome.
    Time Complexity: O(n) where n is the length of the string
    Space Complexity: O(n) due to string slicing creating a new string
    """
    return s == s[::-1]

def is_palindrome_case_insensitive(s1: str) -> bool:
    """
    Check if a string is a palindrome, ignoring case.
    Time Complexity: O(n) where n is the length of the string
    Space Complexity: O(n) due to string operations
    """
    if s1.lower() == s1[::-1].lower():
        return True
    return False

# 4. Remove Duplicates (Keep Order) - e.g., LeetCode 26: Remove Duplicates from Sorted Array (variant)
def remove_duplicates(nums: list[int]) -> list[int]:
    """
    Remove duplicates from a list while preserving order.
    Time Complexity: O(n) where n is the length of the array
    Space Complexity: O(n) for the set and result list
    """
    seen = set()
    result = []
    for num in nums:
        if num not in seen:
            seen.add(num)
            result.append(num)
    return result

# 5. Factorial (Recursive) - e.g., Common interview problem
def factorial(n: int) -> int:
    """
    Calculate the factorial of n using recursion.
    Time Complexity: O(n) recursive calls
    Space Complexity: O(n) for the call stack
    """
    if n <= 1:
        return 1
    return n * factorial(n - 1)

# 6. Fibonacci (Memoization) - e.g., LeetCode 509: Fibonacci Number
def fib_memo(n: int, memo={}) -> int:
    """
    Calculate the nth Fibonacci number using memoization.
    Time Complexity: O(n)
    Space Complexity: O(n) for the memoization dictionary
    Note: In practice, create a new memo dictionary for each call to avoid shared state
    """
    if n <= 1:
        return n
    if n not in memo:
        memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
    return memo[n]

# 6. Fibonacci (DP) - e.g., LeetCode 509: Fibonacci Number
def fib_dp(n: int) -> int:
    """
    Calculate the nth Fibonacci number using dynamic programming.
    Time Complexity: O(n)
    Space Complexity: O(n) for the DP array
    """
    if n <= 1:               # Base case
        return n
    
    dp = [0] * (n+1)         # DP 배열 초기화 (0부터 n까지니까 n+1개)
    dp[1] = 1                # 초기값 설정 (fib(0) = 0, fib(1) = 1)
    
    for i in range(2, n+1):  # 점화식 적용
        dp[i] = dp[i-1] + dp[i-2]
    
    return dp[n]             # 결과 리턴

# 7. Binary Search (Iterative) - e.g., LeetCode 704: Binary Search
def binary_search(arr: list[int], target: int) -> int:
    """
    Find the index of the target in a sorted array using binary search.
    Time Complexity: O(log n) where n is the length of the array
    Space Complexity: O(1)
    """
    left, right = 0, len(arr) - 1
    
    while left <= right:    # 타겟이 마지막 요소인 경우도 고려하기 위하여
        mid = (left + right) // 2
        
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1  # Target not found
