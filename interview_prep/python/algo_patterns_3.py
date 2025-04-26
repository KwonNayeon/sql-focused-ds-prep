# Python Coding Patterns Part 3
# - 코드 전체 암기보다, 각 패턴/알고리즘의 "원리, 시간복잡도, 언제/왜 쓰는지" 설명력에 집중
# - 파이썬 내장 함수(sorted, set, dict, collections 등) 적극 활용
# - 실전에서는 문제 접근법, 엣지케이스, 최적화 아이디어까지 말할 수 있으면 충분
# - Easy~Medium 수준의 문제를 패턴별로 2~3개만 직접 풀고, 풀이 과정 1분 내외로 설명 연습

# Base Case: 재귀 알고리즘에서 재귀 호출을 종료하는 조건
# Edge Case: 알고리즘이 처리해야 하는 극단적이거나 특이한 입력 상황

# ✅ 1. Sorting (정렬)
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

def bubble_sort(arr):
    """
    Bubble Sort (O(n^2))
    - 인접한 원소를 반복적으로 비교/교환
    - 실무에서는 거의 사용 X, 원리 설명용
    """
    n = len(arr)
    for i in range(n):
        for j in range(n-1-i):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr

# 👉 인터뷰 설명 포인트:
# - 각 정렬의 시간복잡도/특징(Quick: 평균 빠름, Merge: 항상 안정적, Bubble: 비효율)
# - 파이썬 내장 sorted()는 TimSort(합병+삽입 혼합)


# 2. DFS/BFS (탐색, 그래프/트리)
def dfs(graph, start, visited=None):
    """
    DFS (깊이 우선 탐색, 재귀/스택)
    - 그래프/트리에서 한 방향으로 끝까지 탐색
    - 시간복잡도 O(V+E)
    """
    if visited is None:
        visited = set()
    visited.add(start)
    for neighbor in graph[start]:
        if neighbor not in visited:
            dfs(graph, neighbor, visited)
    return visited

from collections import deque
def bfs(graph, start):
    """
    BFS (너비 우선 탐색, 큐)
    - 가까운 노드부터 탐색, 최단거리/레벨 탐색에 강점
    - 시간복잡도 O(V+E)
    """
    visited = set([start])
    queue = deque([start])
    while queue:
        node = queue.popleft()
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
    return visited

# 👉 인터뷰 설명 포인트:
# - DFS: 깊이 우선, 재귀/스택, 그래프/트리 순회
# - BFS: 너비 우선, 큐, 최단거리 탐색
# - 언제 어떤 탐색을 쓰는지, 시간복잡도 O(V+E)


# 3. 트리 구조 & 최대 깊이
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def max_depth(root):
    """
    트리의 최대 깊이 (DFS 활용)
    - 시간복잡도: O(n) (n=노드 수)
    """
    if not root:
        return 0
    return 1 + max(max_depth(root.left), max_depth(root.right))

# 👉 인터뷰 설명 포인트:
# - 트리/그래프의 기본 구조(노드, 간선, 루트, 리프)
# - DFS/BFS로 트리/그래프 문제 푸는 원리


# 4. 백트래킹/조합/부분집합
def subsets(nums):
    """
    부분집합(Subset) 생성 (백트래킹)
    - 모든 부분집합을 반환 (O(2^n))
    """
    result = []
    def backtrack(path, idx):
        result.append(path)
        for i in range(idx, len(nums)):
            backtrack(path + [nums[i]], i+1)
    backtrack([], 0)
    return result

def combine(n, k):
    """
    조합(Combination) (n개 중 k개 뽑기, 백트래킹)
    - 시간복잡도: O(nCk * k)
    """
    result = []
    def backtrack(path, start):
        if len(path) == k:
            result.append(path)
            return
        for i in range(start, n+1):
            backtrack(path + [i], i+1)
    backtrack([], 1)
    return result

# 👉 인터뷰 설명 포인트:
# - 백트래킹 원리: 모든 경우의 수 탐색, 조건에 따라 가지치기
# - 부분집합/조합/순열 문제에서의 활용
# - 시간복잡도(부분집합: O(2^n), 조합: O(nCk * k))

