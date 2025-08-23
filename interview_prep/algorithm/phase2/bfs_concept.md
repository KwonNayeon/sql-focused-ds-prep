# BFS 격자 탐색 문제

## 수도코드

```
function BFS(start, target, grid):

    n, m = grid 크기
    
    visited = n×m 배열 (False로 초기화)
    queue = [(start_row, start_col, dist=1)]   # 시작칸 포함이면 1, 이동횟수면 0
    visited[start_row][start_col] = True

    while queue is not empty:
        r, c, d = queue.pop_front()    # 현재 위치와 거리

        if (r, c) == (target_row, target_col):
            return d    # 최단 거리 반환

        for (dr, dc) in [(상, 하, 좌, 우)]:
            nr = r + dr
            nc = c + dc

            if nr, nc 가 grid 범위 안이고
               grid[nr][nc] == 1 (통과 가능) 이고
               visited[nr][nc] == False 이면:

                visited[nr][nc] = True
                queue.push_back((nr, nc, d+1))

    return -1   # 도착 불가
```


## 설명

1. **초기화**

   * `visited`: 같은 칸을 여러 번 큐에 넣는 걸 막기 위해 필요
   * `queue`: BFS는 큐로 레벨 순회. `(row, col, 거리)` 구조로 저장

2. **루프 시작**

   * 큐가 빌 때까지 반복
   * 맨 앞에서 꺼내 현재 위치와 거리 확인

3. **도착 조건**

   * 현재 위치가 목표라면 즉시 `d` 반환
   * BFS 특성상 **처음 도착한 d가 최단거리**

4. **이웃 탐색**

   * 상하좌우 4방향을 돌며 새 좌표 계산
   * 조건 체크 순서:
     ① 범위 안?
     ② 통과 가능한 칸?
     ③ 방문 안 했나?

5. **큐에 추가**

   * 조건 통과하면 방문 처리
   * 큐에 `(새 행, 새 열, d+1)` 삽입

6. **실패 시 -1**

   * 큐 다 비우고도 도착 못 하면 길 없음


## 기억할 것

* 시작 거리: **칸 수 기준**이면 `1`, **이동 횟수 기준**이면 `0`
* 방문 체크는 **큐에 넣을 때 True**
* 종료 조건은 **도착 즉시 리턴**
* 조건 체크 순서: **범위 → 통로 → 미방문**
* "꺼내고 -> 검사하고 -> 조건에 맞으면 넣고"를 반복


## 관련 문제
프로그래머스 - 게임 맵 최단거리 문제

```
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
```