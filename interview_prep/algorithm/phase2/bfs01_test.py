from collections import deque

def in_range(r, c, n, m):
    return 0 <= r < n and 0 <= c < m

def passable(grid, r, c):
    # 흰 칸(1)만 통과
    return grid[r][c] == 1

def solution(maps):
    n, m = len(maps), len(maps[0])
    
    # 시작이 막혀있으면 바로 불가능
    if maps[0][0] == 0 or maps[n-1][m-1] == 0:
        return -1

    # 방문 배열
    visited = [[False] * m for _ in range(n)]
    
    # queue
    q = deque()
    # TODO 1) 시작점 push: (0, 0, 시작거리)
    q.append((0, 0, 1))
    # TODO 2) 시작점 방문 표시
    visited[0][0] = True

    # 방향 벡터 (상/하/좌/우)
    dirs = [(-1,0), (1,0), (0,-1), (0,1)]
    
    # bfs
    while q:
        # TODO 3) 현재 위치/거리 꺼내기 (r, c, d)
        r, c, d = q.popleft()

        # TODO 4) 도착점이면 거리 리턴: (r, c) == (n-1, m-1)
        if (r, c) == (n-1, m-1):
            return d

        # 이웃 탐색
        for dr, dc in dirs:
            # TODO 5) 새 위치
            nr, nc = r + dr, c + dc

            # TODO 6) 경계 & 통로 & 미방문 체크
            # if in_range(nr, nc, n, m) and passable(maps, nr, nc) and not visited[nr][nc]:
            #     TODO 7) 방문 표시 & 큐에 (nr, nc, d+1)
            if in_range(nr, nc, n, m) and passable(maps, nr, nc) and not visited[nr][nc]:
                visited[nr][nc] = True
                q.append((nr, nc, d + 1))

    # 도달 불가
    return -1



# 테스트 실행
print(solution([[1,1,1],[0,1,0],[0,1,1]]))  # 예상: 5
print(solution([[1,0],[0,1]]))              # 예상: -1
print(solution([[1]]))                      # 예상: 1