# ⭐️ 5. Valid Parentheses (e.g., LeetCode 20 Valid Parentheses)
"""
1. 여는 괄호가 나오면 스택에 추가.
2. 닫는 괄호가 나오면, 스택에서 가장 최근에 추가된 여는 괄호를 꺼내 짝이 맞는지 확인.
3. 모든 괄호가 올바르게 짝지어지기 위해서는:
  - 닫는 괄호는 반드시 직전에 나온 여는 괄호와 짝이 맞아야 함.
  - 문자열 끝까지 확인한 후 스택이 비어있어야 함(모든 여는 괄호에 대응하는 닫는 괄호가 있어야 함).
"""

# Solution 1
def is_valid(s: str) -> bool:
    """
    Determine if the input string has valid parentheses.
    Time Complexity: O(n) where n is the length of the string
    Space Complexity: O(n) in worst case for the stack
    """
    stack = []
    mapping = {')': '(', ']': '[', '}': '{'}
    for char in s:
        if char in mapping:
            top = stack.pop() if stack else '#'
            if mapping[char] != top:
                return False
        else:
            stack.append(char)
    return not stack

# Solution 2: 내가 이해하기 쉬운 버전
class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        
        # key: 닫는 괄호, value: 대응하는 여는 괄호
        mapping = {')': '(', '}': '{', ']': '['}
        
        for char in s:  # s = "()[]{}"
            # 현재 문자가 닫는 괄호인 경우
            if char in mapping:
                # 스택이 비어있는데 닫는 괄호가 나온 경우 (짝이 없음)
                if not stack:
                    return False
                
                # 스택에서 가장 최근에 추가된 여는 괄호를 꺼냄
                top = stack.pop()
                
                if mapping[char] != top:
                    return False
            # 현재 문자가 여는 괄호인 경우
            else:
                stack.append(char)
        
        # 모든 문자 처리 후, 스택이 비어있으면 모든 괄호의 짝이 맞음 (True)
        # 스택에 요소가 남아있으면 짝이 맞지 않는 여는 괄호가 있음 (False)
        return not stack