# Coding Interview Prep
# 목표: 시간복잡도 신경쓰지 말고 일단 돌아가는 코드 만들기

# 1. Palindrome Check - 리뷰에서 나온 문제
def is_palindrome(s):
    """Check if a string is a palindrome (ignores case and spaces)"""
    clean = ''.join(c.lower() for c in s if c.isalnum())
    return clean == clean[::-1]

# 2. Two Sum - 가장 기본적인 문제
def two_sum(nums, target):
    """Return indices of two numbers that add up to target"""
    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            if nums[i] + nums[j] == target:
                return [i, j]
    return []

# 3. Reverse String
def reverse_string(s):
    """Reverse a string"""
    return s[::-1]

# 4. Valid Anagram
def is_anagram(s, t):
    """Check if two strings are anagrams"""
    return sorted(s) == sorted(t)

# 5. Find Missing Number
def find_missing_number(nums):
    """Find missing number in array [1,2,4,5] -> 3"""
    if not nums:
        return 1
    full_set = set(range(1, max(nums) + 2))
    return list(full_set - set(nums))[0]

# 6. Move Zeros to End
def move_zeros(nums):
    """Move all zeros to end [0,1,0,3,12] -> [1,3,12,0,0]"""
    result = []
    zeros = []
    for num in nums:
        if num == 0:
            zeros.append(num)
        else:
            result.append(num)
    return result + zeros

# 7. Longest Common Prefix
def longest_common_prefix(strs):
    """Find longest common prefix ["flower","flow","flight"] -> "fl" """
    if not strs:
        return ""
    
    prefix = strs[0]
    for string in strs[1:]:
        while not string.startswith(prefix):
            prefix = prefix[:-1]
            if not prefix:
                return ""
    return prefix

# 8. First Unique Character
def first_unique_char(s):
    """Find first unique character "leetcode" -> 0 (index of 'l')"""
    for i, char in enumerate(s):
        if s.count(char) == 1:
            return i
    return -1

# 9. Remove Duplicates
def remove_duplicates(nums):
    """Remove duplicates from list"""
    return list(set(nums))

# 10. Count Characters and Words
def count_chars_words(s):
    """Count characters and words"""
    return len(s), len(s.split())

# 11. Simple String Search
def find_substring(haystack, needle):
    """Find first occurrence of needle in haystack"""
    if needle in haystack:
        return haystack.index(needle)
    return -1

# 12. Merge Two Sorted Lists
def merge_sorted_lists(l1, l2):
    """Merge two sorted lists"""
    merged = []
    i = j = 0
    
    while i < len(l1) and j < len(l2):
        if l1[i] <= l2[j]:
            merged.append(l1[i])
            i += 1
        else:
            merged.append(l2[j])
            j += 1
    
    # Add remaining elements
    merged.extend(l1[i:])
    merged.extend(l2[j:])
    return merged

# 실전 팁:
# 1. 간단하고 읽기 쉬운 코드 작성
# 2. 브루트포스 먼저, 최적화는 나중에
# 3. Edge case 간단하게 처리
# 4. 테스트 케이스로 검증

# 예시 테스트:
if __name__ == "__main__":
    # 간단한 테스트 케이스들
    print(is_palindrome("A man a plan a canal Panama"))  # True
    print(two_sum([2, 7, 11, 15], 9))  # [0, 1]
    print(reverse_string("hello"))  # "olleh"
    print(is_anagram("listen", "silent"))  # True
    print(find_missing_number([1, 2, 4, 5]))  # 3
    print(move_zeros([0, 1, 0, 3, 12]))  # [1, 3, 12, 0, 0]
