# Sorting
"""
버블 정렬: 인접한 원소들을 비교하고 교환하며 큰 값을 맨 뒤로 이동
삽입 정렬: 정렬된 부분에 원소를 하나씩 적절한 위치에 삽입
퀵 정렬: 피벗을 기준으로 배열을 분할하여 재귀적으로 정렬 (분할 정복)
합병 정렬: 배열을 절반으로 나누어 재귀적으로 정렬한 후 병합 (분할 정복)
"""

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
# Solution 1
def bubble_sort(arr):
    arr_len = len(arr) - 1
    for i in range(arr_len):
        for j in range(arr_len):
            # Compare adjacent elements and swap if they're in the wrong order
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr

# Solution 2: 최적화 버전
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


# ✅ Insertion sort
def insertion_sort(arr):
    """
    Insertion Sort (평균 및 최악 O(n^2), 최선 O(n))
    - 정렬된 부분에 새 원소를 적절한 위치에 삽입
    - 작은 데이터셋에 효율적, 거의 정렬된 데이터에 유리
    """
    for i in range(1, len(arr)):  # 첫 원소는 이미 정렬됐다고 가정하고 두 번째부터 시작
        key = arr[i]  # 현재 삽입할 원소 (정렬되지 않은 부분의 첫 원소)
        j = i - 1     # 정렬된 부분의 마지막 인덱스
        
        # key보다 큰 원소들을 오른쪽으로 이동
        # 이 while 루프는 두 가지 조건으로 종료됨:
        # 1) j < 0 (배열 시작 이전에 도달)
        # 2) arr[j] <= key (key보다 작거나 같은 원소 발견)
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]  # 현재 원소를 한 칸 오른쪽으로 이동
            j -= 1  # 왼쪽으로 이동하여 계속 비교
        
        # 적절한 위치에 key 삽입
        # j+1이 "적절한 위치"가 되는 이유:
        # - 루프가 j < 0으로 끝났다면: j+1 = 0 (배열의 맨 앞)
        # - 루프가 arr[j] <= key로 끝났다면: j+1은 key가 들어갈 위치
        arr[j + 1] = key  # 이 위치는 루프 종료 방식에 따라 달라짐
    
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
    
    mid = len(arr)//2   # quotient
    
    # 재귀적으로 분할 및 정렬
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    
    # 병합 과정
    result = []
    i = j = 0
    
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
            
    result += left[i:]   # left 배열에 남은 원소들 모두 추가
    result += right[j:]  # right 배열에 남은 원소들 모두 추가
    
    return result

# 주석으로 스텝을 나눈 버전
def merge_sort(arr):
    """
    Merge Sort (always O(n log n), stable sort)
    - Recursively divide the list in half and merge sorted halves
    """
    # Step 1: Base case - a list with 0 or 1 element is already sorted
    if len(arr) <= 1:
        return arr
    
    # Step 2: Divide - find the middle point to divide the array
    mid = len(arr)//2   # quotient
    
    # Step 3: Conquer - recursively sort both halves
    left = merge_sort(arr[:mid])    # Sort left half
    right = merge_sort(arr[mid:])   # Sort right half
    
    # Step 4: Merge - combine the sorted halves
    result = []
    i = j = 0   # Pointers for left and right arrays
    
    # Step 5: Compare elements from both arrays and merge in sorted order
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])  # Add smaller element from left array
            i += 1
        else:
            result.append(right[j])  # Add smaller element from right array
            j += 1
    
    # Step 6: Add remaining elements (if any)
    result += left[i:]   # Add any remaining elements from left array
    result += right[j:]  # Add any remaining elements from right array
    
    # Step 7: Return the merged sorted array
    return result

