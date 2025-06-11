"""
- Problem: Two Sum (Part 2)
- Link: https://datalemur.com/questions/python-two-sum-2
  - Input/Output/Constraints:
    - Given an array of integers sorted in non-decreasing order
    - Return indices of two numbers that add up to the target
    - At most one solution exists
    - If no valid solution, return [-1, -1]
    - Return indices in increasing order (e.g. [1,3], not [3,1])
    - Must use constant O(1) extra space
    - e.g. Input: nums = [1, 3, 4, 5, 7, 12, 15], target = 9 -> Output: [2,3]
    
- Approach:
  - Use two-pointer technique since array is sorted
  - Initialize left pointer at beginning (index 0) and right pointer at end (index n-1)
  - While left < right:
    - Calculate sum of nums[left] + nums[right]
    - If sum equals target, return [left, right]
    - If sum < target, increment left pointer to increase sum
    - If sum > target, decrement right pointer to decrease sum
  - If no solution found, return [-1, -1]
  
- Time/Space Complexity:
  - Time Complexity: O(n) - at worst, traverse array once
  - Space Complexity: O(1) - only use two pointer variables regardless of input size
  
- Edge Cases:
  - Empty array (return [-1, -1])
  - No solution exists (return [-1, -1])
  - Negative numbers (handled naturally by algorithm)
"""
def sorted_two_sum(nums, target):
    left, right = 0, len(nums) - 1
    
    while left < right:
        if target == nums[left] + nums[right]:
            return [left, right]
        elif target > nums[left] + nums[right]:
            left += 1
        else:
            right -= 1
            
    return [-1, -1]
