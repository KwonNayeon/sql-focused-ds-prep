# DFS/BFS (탐색, 그래프/트리)

# DFS: 깊이 우선, 재귀/스택, 그래프/트리 순회
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
