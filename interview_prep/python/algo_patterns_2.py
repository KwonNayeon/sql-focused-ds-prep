# Python Coding Patterns Part 2

# 8. Sliding Window - Maximum Sum of Subarray Size K
def max_subarray_sum(nums: list[int], k: int) -> int:
    max_sum = current = sum(nums[:k])
    for i in range(k, len(nums)):
        current += nums[i] - nums[i-k]
        max_sum = max(max_sum, current)
    return max_sum


# 9. Valid Parentheses - Stack
def is_valid(s: str) -> bool:
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


# 10. Contains Duplicate - Set
def contains_duplicate(nums: list[int]) -> bool:
    return len(nums) != len(set(nums))


# 11. Linked List Cycle - Fast and Slow Pointers
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def has_cycle(head: ListNode) -> bool:
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        if slow == fast:
            return True
    return False


# 12. Reverse Array - In-place Two-pointer
def reverse_array(arr: list[int]) -> list[int]:
    left, right = 0, len(arr)-1
    while left < right:
        arr[left], arr[right] = arr[right], arr[left]
        left += 1
        right -= 1
    return arr


# 13. Can Construct (Anagram) - Frequency Counter
def can_construct(ransomNote: str, magazine: str) -> bool:
    from collections import Counter
    return not (Counter(ransomNote) - Counter(magazine))
