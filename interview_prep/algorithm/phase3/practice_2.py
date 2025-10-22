# 7. Longest Common Prefix

# Input: strs = ["flower","flow","flight"]
# Output: "fl"

def longest_common_prefix(strs):
    if not strs:
        return ""
    
    prefix = strs[0]
    for string in strs[1:]:
        while not string.startswith(prefix):    # string이 prefix로 시작하는지 체크 (예: "flow".startswith("flower") → False)
            prefix = prefix[:-1]    # 마지막 글자를 제외한 나머지
            if not prefix:
                return ""
    return prefix

# 8. First Unique Character

# 방법 1: enumerate 사용 (더 파이썬스럽고 깔끔)
def first_unique_char(s):
    for i, char in enumerate(s):  # 인덱스와 값을 동시에
        if s.count(char) == 1:
            return i
    return -1

# 방법 2: range(len()) 사용 (더 전통적)
def first_unique_char(s):
    for i in range(len(s)):       # 인덱스만 가져와서
        char = s[i]                # 값을 따로 접근
        if s.count(char) == 1:
            return i
    return -1

# 9. Remove Duplicates
def remove_duplicates(nums):
    """Remove duplicates from list"""
    return list(set(nums))

# 10. Count Characters and Words
def count_chars_words(s):
    """Count characters and words
    Input: "hello world" 
    Output: (11, 2) - 11 characters, 2 words
    """
    return len(s), len(s.split())

# 11. Simple String Search
def find_substring(haystack, needle):
    """Find first occurrence of needle in haystack
    Input: haystack="hello world", needle="world" → Output: 6
    Input: haystack="leetcode", needle="code" → Output: 4
    Input: haystack="hello", needle="bye" → Output: -1
    """
    if needle in haystack:
        return haystack.index(needle)
    return -1

# 12. Merge Two Sorted Lists
def merge_sorted_lists(l1, l2):
    """Merge two sorted lists
    Input: l1=[1,2,4], l2=[1,3,4] → Output: [1,1,2,3,4,4]
    """
    merged = []
    i = j = 0
    
    while i < len(l1) and j < len(l2):
        if l1[i] <= l2[j]:
            merged.append(l1[i])
            i += 1
        else:
            merged.append(l2[j])
            j += 1
    
    # extend: 리스트의 각 요소를 펼쳐서 추가 (예: [1,2].extend([3,4]) → [1,2,3,4])
    merged.extend(l1[i:])
    merged.extend(l2[j:])
    return merged

# 테스트:
if __name__ == "__main__":
    print("=== Longest Common Prefix Tests ===")
    print(longest_common_prefix(["flower", "flow", "flight"]))  # "fl"
    print(longest_common_prefix(["dog", "racecar", "car"]))  # ""
    print(longest_common_prefix(["dog", "dog", "dog"]))  # "dog"
    
    print("\n=== First Unique Character Tests ===")
    print(first_unique_char("leetcode"))  # 0
    print(first_unique_char("loveleetcode"))  # 2
    print(first_unique_char("aabb"))  # -1
    
    print("\n=== Remove Duplicates Tests ===")
    print(remove_duplicates([1, 2, 2, 3, 3, 4]))  # [1, 2, 3, 4]
    print(remove_duplicates([1, 1, 1, 1]))  # [1]
    
    print("\n=== Count Characters and Words Tests ===")
    print(count_chars_words("hello world"))  # (11, 2)
    print(count_chars_words("I love Python"))  # (14, 3)
    print(count_chars_words(""))  # (0, 0)
    
    print("\n=== Find Substring Tests ===")
    print(find_substring("hello world", "world"))  # 6
    print(find_substring("leetcode", "code"))  # 4
    print(find_substring("hello", "bye"))  # -1
    
    print("\n=== Merge Sorted Lists Tests ===")
    print(merge_sorted_lists([1, 2, 4], [1, 3, 4]))  # [1, 1, 2, 3, 4, 4]
    print(merge_sorted_lists([1, 3, 5], [2, 4, 6]))  # [1, 2, 3, 4, 5, 6]
    print(merge_sorted_lists([], [1, 2]))  # [1, 2]
