# Sorting

"""
BUBBLE SORT
-----------
# Time complexity: O(n²) in worst and average cases, O(n) in best case (when already sorted)
# Space complexity: O(1) - in-place sorting

# Key points:
# 1. Compare adjacent elements and swap if they're in wrong order
# 2. After each pass, the largest unsorted element "bubbles up" to its correct position
# 3. We can optimize by reducing comparisons in each subsequent pass
# 4. Simple to implement but inefficient for large datasets
# 5. Stable sort - maintains relative order of equal elements
"""
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        # We use (n-1-i) as the range because:
        # 1. We need (n-1) comparisons for a list of length n since we compare pairs
        # 2. After each pass, the largest i elements are already sorted at the end
        # 3. So we can reduce the number of comparisons in each subsequent pass
        for j in range(n-1-i):
            # Compare adjacent elements and swap if they're in the wrong order
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr


"""
QUICK SORT
----------
# Time complexity: O(n log n) average case, O(n²) worst case
# Space complexity: O(log n) for recursive call stack

# Key points:
# 1. Divide and conquer algorithm based on partitioning around a pivot
# 2. Select a pivot element (first, last, middle, or random)
# 3. Partition: place elements < pivot to left and elements ≥ pivot to right
# 4. Recursively sort the left and right subarrays
# 5. Fast in practice due to good cache locality
# 6. Unstable sort - may change relative order of equal elements
# 7. Performance depends heavily on pivot selection
"""
# solution 1
def quick_sort(arr):
    """
    Quick Sort (Divide and Conquer, 평균 O(n log n), 최악 O(n^2))
    - 리스트를 피벗 기준으로 좌/우로 나눠 재귀적으로 정렬
    - 실무에서는 파이썬 내장 sorted()가 TimSort(합병+삽입) 사용
    """
    if len(arr) <= 1:
        return arr
    pivot = arr[0]
    left = [x for x in arr[1:] if x < pivot]
    right = [x for x in arr[1:] if x >= pivot]
    return quick_sort(left) + [pivot] + quick_sort(right)

# solution 2: 내가 이해하기 쉬운 버전
def quick_sort(arr):
    """
    Quick Sort (Divide and Conquer, 평균 O(n log n), 최악 O(n^2))
    - 리스트를 피벗 기준으로 좌/우로 나눠 재귀적으로 정렬
    """
    # 기저 조건: 배열 길이가 1 이하면 이미 정렬된 상태
    if len(arr) <= 1:
        return arr
    
    # 첫 번째 원소를 피벗으로 선택
    pivot = arr[0]
    
    # 피벗보다 작은 원소들은 왼쪽 배열에, 크거나 같은 원소들은 오른쪽 배열에 모음
    left = []
    right = []
    
    # 피벗을 제외한 나머지 원소들을 분류
    for x in arr[1:]:
        if x < pivot:
            left.append(x)  # 피벗보다 작으면 왼쪽 배열에 추가
        else:  # x >= pivot
            right.append(x)  # 피벗보다 크거나 같으면 오른쪽 배열에 추가
    
    # 왼쪽과 오른쪽 배열에 대해 재귀적으로 퀵 정렬 수행 후 결과 합침
    return quick_sort(left) + [pivot] + quick_sort(right)


"""
MERGE SORT
----------
# Time complexity: O(n log n) consistently (worst, average, and best case)
# Space complexity: O(n) - requires additional space for merging

# Key points:
# 1. Divide and conquer algorithm that splits, sorts, and merges
# 2. Divide array into two halves and recursively sort each half
# 3. Merge the sorted halves by comparing elements one by one
# 4. Consistent performance regardless of input data
# 5. Stable sort - maintains relative order of equal elements
# 6. Good for linked lists and external sorting
# 7. Trade-off: guaranteed O(n log n) but requires extra space
"""
def merge_sort(arr):
    """
    Merge Sort (항상 O(n log n), 안정 정렬)
    - 리스트를 반으로 쪼개 재귀적으로 정렬 후 병합
    """
    if len(arr) <= 1:
        return arr
    mid = len(arr)//2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    result = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    result += left[i:]
    result += right[j:]
    return result