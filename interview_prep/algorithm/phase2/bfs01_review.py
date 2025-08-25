# 게임 맵 최단거리 복습

from collections import deque

def solution(maps):
    n, m = len(maps), len(maps[0])
    visited = [[False] * m for _ in range(n)]

    def in_range(r, c):
        return 0 <= r < n and 0 <= c < m

    def passable(r, c):
        return maps[r][c] == 1

    def bfs(start_r, start_c):
        if maps[0][0] == 0 or maps[n-1][m-1] == 0:
            return -1
    
        visited[0][0] = True
    
        q = deque([(0, 0, 1)])
    
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    
        while q:
            r, c, d = q.popleft()

            if (start_r, start_c) == (n-1, m-1):
                return d
            
            for dr, dc in dirs:
                nr = start_r + dr
                nc = start_c + dc

                if in_range(nr, nc) and passable(nr, nc) and not visited[nr][nc]:
                    visited[nr][nc] = True
                    q.append((nr, nc, d+1))

        return -1
    
    return bfs(0, 0)



# 테스트 케이스
test_case = [
    [1,0,1,1,1],
    [1,0,1,0,1],
    [1,0,1,1,1],
    [1,1,1,0,1],
    [0,0,0,0,1]
]

print(solution(test_case))  # 예상 결과: 11