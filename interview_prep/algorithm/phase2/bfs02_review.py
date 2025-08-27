# Number of Islands (BFS) 복습
from typing import List
from collections import deque

class Solution:
    def numIslandsBFS(self, grid: List[List[str]]) -> int:
        n, m = len(grid), len(grid[0])
        visited = [[False] * m for _ in range(n)]
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        islands = 0

        def in_range(r, c):
            return 0 <= r < n and 0 <= c < m
        
        def passable(r, c):
            return grid[r][c] == "1"

        def bfs(r, c):
            q = deque([(r, c)])
            visited[r][c] = True

            while q:
                cur_r, cur_c = q.popleft()

                for dr, dc in dirs:
                    nr = cur_r + dr
                    nc = cur_c + dc

                    if in_range(nr, nc) and passable(nr, nc) and not visited[nr][nc]:
                        visited[nr][nc] = True
                        q.append((nr, nc))

        for r in range(n):
            for c in range(m):
                if grid[r][c] == "1" and not visited[r][c]:
                    islands += 1
                    bfs(r, c)

        return islands



# 테스트 1: 하나의 큰 섬
grid1 = [
    ["1","1","0"],
    ["1","0","0"],
    ["0","0","1"]
]
# 예상: 2개 섬

# 테스트 2: 모든 칸이 물
grid2 = [
    ["0","0"],
    ["0","0"]
]
# 예상: 0개 섬

# 테스트 3: 모든 칸이 땅  
grid3 = [
    ["1","1"],
    ["1","1"]
]
# 예상: 1개 섬

solution = Solution()
print(solution.numIslandsBFS(grid1))
print(solution.numIslandsBFS(grid2))
print(solution.numIslandsBFS(grid3))
