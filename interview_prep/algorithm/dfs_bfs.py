# DFS/BFS (탐색, 그래프/트리)
'''
DFS vs BFS 비교:

1. 기본 특성
   DFS: 깊이 우선 탐색 - 한 경로를 끝까지 탐색 후 다른 경로로
   BFS: 너비 우선 탐색 - 가까운 노드부터 단계별로 탐색

2. 구현 방식
   DFS: 재귀 또는 스택 사용
   BFS: 큐(deque) 사용

3. 장단점
   DFS 장점: 메모리 효율적, 구현 간단(재귀), 백트래킹에 적합
   DFS 단점: 최단 경로 보장 안됨, 무한 그래프에서 위험
   
   BFS 장점: 최단 경로 찾기 좋음, 레벨별 탐색에 적합
   BFS 단점: 메모리 사용량 많음

4. 시간복잡도
   둘 다 O(V+E) - V:노드 수, E:간선 수

5. 활용 사례
   DFS: 경로 존재 여부, 사이클 탐지, 위상 정렬, 미로 탐색
   BFS: 최단 경로, 네트워크 분석, 레벨별 탐색
'''

# DFS: 깊이 우선, 재귀/스택, 그래프/트리 순회
def dfs(
    graph: dict,         # {노드: [이웃노드들]} 형태의 그래프
    start,               # 탐색 시작 노드 
    visited: set = None  # 방문 노드 추적용 집합
) -> set:                # 방문한 모든 노드 집합 반환
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


# BFS: 너비 우선, 큐, 최단거리 탐색
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


