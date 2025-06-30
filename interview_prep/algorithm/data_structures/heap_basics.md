# Python Heap 정리 가이드

> **Study Source**: [파이썬의 heapq 모듈로 힙 자료구조 사용하기](https://www.daleseo.com/python-heapq/)  

## 모듈 임포트
```python
from heapq import heappush, heappop
```

## 1. 최소 힙 생성 및 원소 추가
```python
from heapq import heappush

heap = []

# 힙에 원소들 추가
heappush(heap, 4)
heappush(heap, 1)
heappush(heap, 7)
heappush(heap, 3)
heappush(heap, 8)
heappush(heap, 5)

print(heap)  # [1, 3, 5, 4, 8, 7]
```

## 2. 힙에서 원소 삭제
```python
from heapq import heappop

# 가장 작은 원소를 삭제 (시간복잡도: O(log n))
print(heappop(heap))  # 1
print(heap)           # [3, 4, 5, 7, 8]
```

## 3. 삭제하지 않고 최솟값 조회
```python
# 최솟값 읽기
print(heap[0])  # 3

# ⚠️ 주의사항: 
# 두 번째로 작은 원소를 얻기 위해 heap[1]로 접근하면 안 됨
# heappop()을 통해 가장 작은 원소 삭제 후 heap[0]으로 새로운 최솟값에 접근
```

## 4. 기존 리스트를 힙으로 변환
```python
from heapq import heapify

# 리스트를 힙으로 변환
heap = [4, 1, 7, 3, 8, 5]
heapify(heap)
print(heap)  # [1, 3, 5, 4, 8, 7]
```

### heapify() 주의사항
```python
# ⚠️ heapify()는 원본 리스트를 직접 수정함
# 원본 보존이 필요한 경우 복제 후 사용
nums = [4, 1, 7, 3, 8, 5]
heap = nums[:]  # 리스트 복제
heapify(heap)

print(nums)  # [4, 1, 7, 3, 8, 5] (원본 보존)
print(heap)  # [1, 3, 5, 4, 8, 7] (힙으로 변환)
```

## 5. 응용 - 최대 힙 구현
```python
from heapq import heappush, heappop

nums = [4, 1, 7, 3, 8, 5]
heap = []

# 음수로 변환하여 최대 힙처럼 사용
for num in nums:
    heappush(heap, (-num, num))

# 최대값부터 출력
while heap:
    print(heappop(heap)[1])  # 8, 7, 5, 4, 3, 1
```

## 6. 응용 - n번째 최소값/최대값

### 방법 1: 직접 구현
```python
from heapq import heappush, heappop

def nth_smallest(nums, n):
    heap = []
    for num in nums:
        heappush(heap, num)
    
    nth_min = None
    for _ in range(n):
        nth_min = heappop(heap)
    
    return nth_min

print(nth_smallest([4, 1, 7, 3, 8, 5], 3))  # 4
```

### 방법 2: heapify() 활용
```python
def nth_smallest(nums, n):
    heapify(nums)
    
    nth_min = None
    for _ in range(n):
        nth_min = heappop(nums)
    
    return nth_min
```

### 방법 3: nsmallest()/nlargest() 활용
```python
from heapq import nsmallest, nlargest

# n번째 최솟값
print(nsmallest(3, [4, 1, 7, 3, 8, 5])[-1])  # 4

# n번째 최댓값  
print(nlargest(3, [4, 1, 7, 3, 8, 5])[-1])   # 5
```

## 7. 응용 - 힙 정렬
```python
from heapq import heappush, heappop

def heap_sort(nums):
    heap = []
    
    # 모든 원소를 힙에 추가
    for num in nums:
        heappush(heap, num)
    
    # 힙에서 하나씩 꺼내어 정렬된 리스트 생성
    sorted_nums = []
    while heap:
        sorted_nums.append(heappop(heap))
    
    return sorted_nums

print(heap_sort([4, 1, 7, 3, 8, 5]))  # [1, 3, 4, 5, 7, 8]
```
