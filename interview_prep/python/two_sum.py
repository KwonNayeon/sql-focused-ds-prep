"""
- Problem: Two Sum
  - Input/Output/Constraints:
    - Given an array of integers and a target value
    - Return indices of two numbers that add up to the target
    - Exactly one solution exists
    - Cannot use the same element twice
    - Return indices in any order
    - e.g. Input: nums = [2,7,11,15], target = 9 -> Output: [0,1]

- Approach:
  - Use a hash map (dictionary) to store each number and its index
  - Iterate through the array, for each number check if (target - current number) exists in the hash map
  - If it exists, return the current index and the found index from the hash map
  - If not, store the current number and index in the hash map and continue
  
- Time/Space Complexity:
  - Time Complexity: O(n) - only need to traverse the array once
  - Space Complexity: O(n) - in worst case, store all elements in hash map (not O(1))
  
- Edge Cases:
  - Empty array (handle according to problem constraints)
  - Negative numbers (no impact)
  - Duplicate numbers (can use if indices are different)
"""
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        seen = {}

        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]

            else:
                seen[num] = i
