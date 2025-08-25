'''
프로그래머스 - 게임 맵 최단거리 문제

조건:
- 흰색(1), 검은색(0)으로 이루어진 5x5 맵
- 캐릭터는 흰색 부분만 갈 수 있음
- 동, 서, 남, 북 방향으로 한 칸씩 이동
- 반환해야 하는 값
  - 캐릭터가 상대 팀 진영에 도착하기 위해서 지나가야 하는 칸의 개수의 최솟값
  - 상대 팀 진영에 도착할 수 없을 때는 -1을 반환
  
제한사항:
 - 1 <= n, m <= 100
 - there is no n!=1 & m!=1
 - 캐릭터는 게임 맵의 (1,1)에 위치, 상대방 진영은 (n, m) 위치

수도코드:
function BFS(start, target, grid):
    n, m = grid의 크기

    visited = nxm 배열 (False로 초기화)
    queue = [[start_row, start_col, dist=1]]    # 시작칸을 포함하면 distance=1
    visited[start_row][start_col] = True

    while queue is not empty:
        r, c, d = queue.popleft()

        if (r, c) == (target_row, target_col):
            return d

        for (dr, dc) in [(상, 하, 좌, 우)]:
            nr = r + dr
            nc = r + dc

            if nr, nc가 grid 범위 안이고
                grid[nr][nc] == 1이고
                visited[nr][nc] == False이면:

                    visited[nr][nc] = True
                    queue.append((nr, nc, d+1))

    return -1   # 도착 불가

시간 복잡도:

공간 복잡도:

'''
from collections import deque

def in_range(r, c, n, m):
    return 0 <= r < n and 0 <= c < m

def passable(grid, r, c):
    return grid[r][c] == 1

def solution(maps):
    n, m = len(maps), len(maps[0])

    # Edge case
    if maps[0][0] == 0 or maps[n-1][m-1] == 0:
        return -1
    
    visited = [[False] * m for _ in range(n)]

    q = deque()
    # 시작점 push
    q.append((0, 0, 1))
    # 시작점 방문 표시
    visited[0][0] = True

    # 방향 벡터
    dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    # bfs
    while q:
        r, c, d = q.popleft()

        if (r, c) == (n-1, m-1):
            return d
        
        for dr, dc in dirs:
            nr, nc = r + dr, c + dc

            if in_range(nr, nc, n, m) and passable(maps, nr, nc) and not visited[nr][nc]:
                visited[nr][nc] = True
                q.append((nr, nc, d+1))
    return -1



# 테스트 실행
print(solution([[1,1,1],[0,1,0],[0,1,1]]))  # 예상: 5
print(solution([[1,0],[0,1]]))              # 예상: -1
print(solution([[1]]))                      # 예상: 1