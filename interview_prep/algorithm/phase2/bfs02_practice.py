'''
LeetCode - Number of Islands

조건:
- mxn grid
- 1 = 땅, 0 = 물
- 섬의 수를 반환하는 문제

제한사항:
- m == grid.length
- n == grid[i].length
- 1 <= m, n <= 300
- grid[i][j] is '0' or '1'

BFS/DFS를 사용하는 이유:
- 한 섬을 발견하면 그 섬의 모든 연결된 1들을 방문처리 하기 위함

수도코드:
num_of_island = 0
for 각 칸 (r, c):
    if grid[r][c] == 1 and not visited[r][c]:
        num_of_island += 1
        BFS_또는_DFS로_연결된_모든_1들을_방문처리()

시간 복잡도: O(n×m)
- 각 셀을 최대 한번 방문하기 때문

공간 복잡도: O(n×m)
- visited 배열에 각 셀의 방문여부를 기록
'''
from collections import deque
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:

        n, m = len(grid), len(grid[0])
        
        islands = 0

        visited = [[False] * m for _ in range(n)]

        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

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
                    nr, nc = cur_r + dr, cur_c + dc
                    if in_range(nr, nc) and passable(nr, nc) and not visited[nr][nc]:
                        visited[nr][nc] = True
                        q.append((nr, nc))

        for r in range(n):
            for c in range(m):
                if grid[r][c] == "1" and not visited[r][c]:
                    islands += 1
                    bfs(r, c)

        return islands
