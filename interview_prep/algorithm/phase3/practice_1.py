# 1. Valid Palindrome
def valid_palindrome(s):

    left = 0
    right = len(s) - 1

    while left < right:
        while left < right and not s[left].isalnum():
            left += 1

        while left < right and not s[right].isalnum():
            right -= 1

        if s[left].lower() != s[right].lower():
            return False
        
        left += 1
        right -= 1
        
    return True


# 2. Two Sum - 가장 기본적인 문제
def two_sum(nums, target):
    for i in range(len(nums)):
        for j in range(i+1, len(nums)):
            if nums[i] + nums[j] == target:
                return [i, j]
    return []


# 3. Reverse String
def reverse_string(s):
    return s[::-1]


# 4. Valid Anagram
def is_anagram(s, t):
    return sorted(s) == sorted(t)


# ⭐️ 5. Find Missing Number
def find_missing_number(nums):

    if not nums:
        return 1
    
    nums_set = set(nums)

    for i in range(1, max(nums) + 1):
        if i not in nums:
            return i
        
    return max(nums) + 1


# 6. Move Zeros to End
def move_zeros(nums):
    result = []
    zeros = []

    for num in nums:
        if num == 0:
            zeros.append(num)
        else:
            result.append(num)

    return result + zeros


# 테스트:
if __name__ == "__main__":
    print(valid_palindrome("A man a plan a canal Panama"))  # True
    print(two_sum([2, 7, 11, 15], 9))  # [0, 1]
    print(reverse_string("hello"))  # "olleh"
    print(is_anagram("listen", "silent"))  # True
    print(find_missing_number([1, 2, 4, 5]))  # 3
    print(move_zeros([0, 1, 0, 3, 12]))  # [1, 3, 12, 0, 0]
