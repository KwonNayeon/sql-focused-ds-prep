# 기본 패턴
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

# LeetCode 문제

# 643. Maximum Average Subarray I
class Solution:
    def findMaxAverage(self, nums: List[int], k: int) -> float:
        current_sum = sum(nums[:k]) # 1+12-5-6
        max_sum = current_sum

        for i in range(k, len(nums)):
            current_sum += nums[i] - nums[i-k] # nums[i-k] == nums[0]
            max_sum = max(current_sum, max_sum)

        return max_sum / k

# 2461. Maximum Sum of Distinct Subarrays With Length K (Medium~Hard)
# 방법 1: 내가 가장 이해하기 쉬운 방식, 하지만 시간 초과 뜸
class Solution:
    def maximumSubarraySum(self, nums: List[int], k: int) -> int:
        max_sum = 0

        for i in range(len(nums) - k + 1):
            window = nums[i:i+k]
            if len(set(window)) == k:
                max_sum = max(max_sum, sum(window))

        return max_sum

# 방법 2: 알고리즘 최적화


# Longest Substring Without Repeating Characters
