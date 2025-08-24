# BFS 격자 탐색 문제

## 관련 문제 (난이도순)

1. **게임 맵 최단거리** (프로그래머스) - 기본 BFS 격자 탐색
2. **Number of Islands** (LeetCode) - 섬의 개수, visited 배열 활용
3. **Rotting Oranges** (LeetCode) - 멀티 소스 BFS, 시간 개념
4. **Pacific Atlantic Water Flow** (LeetCode) - 조건부 탐색, 두 번의 BFS

## 수도코드

```
function BFS(start, target, grid):

    n, m = grid 크기
    
    visited = n×m 배열 (False로 초기화)
    queue = [(start_row, start_col, dist=1)]   # 시작칸 포함이면 1, 이동횟수면 0
    visited[start_row][start_col] = True

    while queue is not empty:
        r, c, d = queue.popleft()    # 현재 위치와 거리

        if (r, c) == (target_row, target_col):
            return d    # 최단 거리 반환

        for (dr, dc) in [(상, 하, 좌, 우)]:
            nr = r + dr
            nc = c + dc

            if nr, nc 가 grid 범위 안이고
               grid[nr][nc] == 1 (통과 가능) 이고
               visited[nr][nc] == False 이면:

                visited[nr][nc] = True
                queue.append((nr, nc, d+1))

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

## BFS 명칭 정리

| Python deque | Python list | 설명 |
|-------------|-------------|------|
| `queue.popleft()` | `queue.pop(0)` | 맨 앞에서 빼기 |
| `queue.append()` | `queue.append()` | 맨 뒤에 넣기 |

## 2차원 배열 생성

```python
visited = [[False] * m for _ in range(n)]
# n = 행(세로) 개수, m = 열(가로) 개수
# visited[행][열] 로 접근
```

## 튜플 vs 리스트

```python
q.append((0, 0, 1))      # 튜플 - 변경불가, 좌표+값 묶을 때
q.append([0, 0, 1])      # 리스트 - 변경가능
r, c, d = q.popleft()    # 튜플 언패킹
```
