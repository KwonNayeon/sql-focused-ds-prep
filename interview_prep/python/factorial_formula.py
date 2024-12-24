# ================================================
# Factorial Formula
# ================================================

# [1] 재귀(Recursive) 방식
def factorial_recursive(n):
   """
   재귀 호출을 사용한 팩토리얼 계산
   n! = n × (n-1)!
   
   Args:
       n (int): 팩토리얼을 계산할 양의 정수
       
   Returns:
       int: n의 팩토리얼 값
   """
   if n <= 1:  # Base case
       return 1
   return n * factorial_recursive(n-1)  # Recursive case

# [2] 반복문(Iterative) 방식
def factorial_iterative(n):
   """
   반복문을 사용한 팩토리얼 계산
   n! = 1 × 2 × 3 × ... × n
   
   Args:
       n (int): 팩토리얼을 계산할 양의 정수
       
   Returns:
       int: n의 팩토리얼 값
   """
   result = 1
   for i in range(1, n + 1):
       result *= i  # 각 숫자를 순차적으로 곱함
   return result