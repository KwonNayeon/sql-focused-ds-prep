# Python Coding Patterns Part 2

# 1. Sliding Window (e.g., Maximum Sum of Subarray Size K, Longest Substring Without Repeating Characters)
def max_subarray_sum(nums: list[int], k: int) -> int:
    """
    Find the maximum sum of a subarray of size k.
    Time Complexity: O(n) where n is the length of nums
    Space Complexity: O(1)
    """
    max_sum = curr_sum = sum(nums[:k])
    for i in range(k, len(nums)):
        curr_sum += nums[i] - nums[i - k]
        max_sum = max(max_sum, curr_sum)
    return max_sum

# 2. Prefix Sum (e.g., Range Sum Query)
# 일단 패스
def range_sum(nums: list[int], start: int, end: int) -> int:
    """
    Calculate the sum of elements between indices start and end inclusive.
    Time Complexity: O(n) for building prefix sum, O(1) for query
    Space Complexity: O(n)
    """
    prefix = [0] * (len(nums) + 1)
    for i in range(len(nums)):
        prefix[i + 1] = prefix[i] + nums[i]
    return prefix[end + 1] - prefix[start]

# 3. Anagram Check (e.g., Valid Anagram - LeetCode 242)
def is_anagram(s: str, t: str) -> bool:
    """
    Determine if t is an anagram of s.
    Time Complexity: O(n) where n is the length of the strings
    Space Complexity: O(k) where k is the size of the character set
    """
    from collections import Counter
    return Counter(s) == Counter(t)

# 4. Character Frequency Map (e.g., Longest Repeating Character Replacement)
# 일단 패스
def longest_repeating_character_replacement(s: str, k: int) -> int:
    """
    Find the length of the longest substring containing the same letter after
    replacing at most k characters.
    Time Complexity: O(n) where n is the length of the string
    Space Complexity: O(1) since English alphabet has a fixed size
    """
    from collections import defaultdict
    
    max_length = 0
    max_count = 0  # Count of the most frequent character in the current window
    start = 0
    char_count = defaultdict(int)
    
    for end in range(len(s)):
        char_count[s[end]] += 1
        max_count = max(max_count, char_count[s[end]])
        
        # If the number of replacements needed is greater than k
        if (end - start + 1) - max_count > k:
            char_count[s[start]] -= 1
            start += 1
        
        max_length = max(max_length, end - start + 1)
    
    return max_length

# 5. Valid Parentheses (e.g., LeetCode 20 - Stack)
# 일단 패스
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

# 6. Contains Duplicate (e.g., LeetCode 217)
def contains_duplicate(nums: list[int]) -> bool:
    """
    Determine if the array contains any duplicates.
    Time Complexity: O(n) where n is the length of nums
    Space Complexity: O(n) for the set
    """
    return len(nums) != len(set(nums))

# 7. Linked List Cycle (e.g., LeetCode 141 - Fast and Slow Pointers)
# 이건 봐야함...
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def has_cycle(head: ListNode) -> bool:
    """
    Detect if a linked list has a cycle using Floyd's Tortoise and Hare algorithm.
    Time Complexity: O(n) where n is the number of nodes
    Space Complexity: O(1)
    """
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        if slow == fast:
            return True
    return False

# 8. Can Construct (e.g., Ransom Note - LeetCode 383)
# Example 2
# Counter(ransomNote) = Counter({'a': 2})
# Counter(magazine) = Counter({'a': 1, 'b': 1})
# Counter(ransomNote) - Counter(magazine) = Counter({'a': 1})   # 'b'는 ransomNote에는 없기 때문에, 결과에 아예 안 나옴.
def can_construct(ransomNote: str, magazine: str) -> bool:
    """
    Determine if ransomNote can be constructed from magazine.
    Time Complexity: O(n) where n is the length of magazine + ransomNote
    Space Complexity: O(k) where k is the size of the character set
    """
    from collections import Counter
    return not (Counter(ransomNote) - Counter(magazine))
