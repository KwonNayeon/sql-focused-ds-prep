"""
- Problem: Find Minimum in Rotated Sorted Array
  - Input/Output/Constraints:
    - Input: A rotated sorted array (e.g., [4,5,6,7,0,1,2])
    - Output: The minimum element in the array (e.g., 0)
    - Constraints: Algorithm must run in O(log n) time
    
- Approach:
  - Use binary search to find the minimum element at the pivot point
  - Compare nums[mid] with nums[right] to determine which half contains the minimum
    
- Time/Space Complexity:
  - Time Complexity: O(log n) - binary search approach
  - Space Complexity: O(1) - constant extra space
  
- Edge Cases:
  - Array not rotated, single-element array
"""
class Solution:
    def findMin(self, nums: List[int]) -> int:
        left, right = 0, len(nums) - 1
        
        while left < right:
            mid = (left + right) // 2
            
            if nums[mid] > nums[right]:
                left = mid + 1
            else:
                right = mid
        
        return nums[left]

