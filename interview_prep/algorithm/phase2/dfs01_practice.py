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

시간 복잡도: O(n×m)
- 각 셀을 최대 한번 방문하기 때문

공간 복잡도: O(n×m)
- visited 배열 + 재귀 호출 스택
'''
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:
        n, m = len(grid), len(grid[0])
        visited = [[False] * m for _ in range(n)]
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def in_range(r, c):
            return 0 <= r < n and 0 <= c < m

        def passable(r, c):
            return grid[r][c] == "1"

        def dfs_recursive(r, c):
            visited[r][c] = True

            for dr, dc in dirs:
                nr = r + dr
                nc = c + dc

                if (in_range(nr, nc) and passable(nr, nc) and not visited[nr][nc]):
                    dfs_recursive(nr, nc)

        islands = 0

        for r in range(n):
            for c in range(m):
                if grid[r][c] == "1" and not visited[r][c]:
                    dfs_recursive(r, c)
                    islands += 1

        return islands



# Test cases
sol = Solution()
grid = [
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
]
print(sol.numIslands(grid))
