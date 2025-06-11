"""
Factorial Implementation: Recursive vs Iterative Approaches

Method 1: Recursive Implementation
- Uses function calling itself to compute factorial
- Base case handles n ≤ 1, returns 1
- Each recursive call multiplies n with factorial of (n-1)
"""
def factorial_recursive(n: int) -> int:
    # Base case: factorial of 0 or 1 is 1
    if n <= 1:
        return 1
    
    # Recursive case: n! = n * (n-1)!
    else:
        return n * factorial_recursive(n-1)


"""
Method 2: Iterative Implementation
- Uses a loop to compute factorial
- Initializes result to 1
- Multiplies result by each number from 2 to n
"""
def factorial_iterative(n: int) -> int:
    # Initialize result to 1 (handles case when n is 0 or 1)
    result = 1
    
    # Multiply result by each number from 2 to n
    for i in range(2, n+1):
        result *= i
        
    return result


"""
Interview Explanation Points:

Recursive Approach:
1. Conceptually matches the mathematical definition: n! = n × (n-1)!
2. Elegant and concise implementation
3. Trade-offs:
   - Time Complexity: O(n) - makes n function calls
   - Space Complexity: O(n) - uses call stack space
   - Risk of stack overflow for large n values

Iterative Approach:
1. More efficient implementation using a simple loop
2. Builds the result by multiplying incrementally
3. Trade-offs:
   - Time Complexity: O(n) - loops n times
   - Space Complexity: O(1) - uses constant space
   - Generally preferred in production code for large values

When asked in interviews:
- Start with the recursive solution as it's intuitive
- Mention that it's not the most efficient implementation
- Offer the iterative solution as an optimization
- Discuss trade-offs based on requirements (readability vs performance)
- For very large n, mention potential for using libraries or memoization
"""
