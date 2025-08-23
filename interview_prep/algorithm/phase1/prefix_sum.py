# Prefix Sum
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


# LeetCode 문제

# 303. Range Sum Query - Immutable
class NumArray:
    def __init__(self, nums):
        # Create and compute the prefix sum array during initialization
        self.prefix = [0] * (len(nums) + 1)
        
        for i in range(len(nums)):
            self.prefix[i+1] = self.prefix[i] + nums[i]
    
    def sumRange(self, left, right):
        # Return the range sum in O(1) time
        return self.prefix[right + 1] - self.prefix[left]


