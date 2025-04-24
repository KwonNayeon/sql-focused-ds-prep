# LeetCode 문제

# 217. Contains Duplicate

# Solution 1: Using a set to check for duplicates
# Time Complexity: O(n)      # We check each number once
# Space Complexity: O(n)     # In the worst case, the set stores all numbers
class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        seen = set()

        for i in nums:
            if i in seen:
                return True
            seen.add(i)
        return False


# Solution 2: Using set and comparing lengths
# Time Complexity: O(n)      # Making a set from the list takes O(n) time
# Space Complexity: O(n)     # The set can have up to n unique numbers
def contains_duplicate(nums: list[int]) -> bool:

    return len(nums) != len(set(nums))
