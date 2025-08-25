# DFS 격자 탐색 문제

## 관련 문제

1. **Number of Islands** (LeetCode) - DFS/백트래킹 기초
2. **N-Queens** (LeetCode) - 전형적인 백트래킹
3. **Combination Sum** (LeetCode) - 조합 생성 백트래킹

## 수도코드

```
function DFS(start_r, start_c, grid):
    n, m = grid 크기
    
    visited = n×m 배열 (False로 초기화)
    
    def dfs_recursive(r, c):
        visited[r][c] = True    # 현재 위치 방문 처리
        
        # 목표 조건 체크 (문제에 따라 다름)
        if 목표_조건_만족:
            # 처리 로직
        
        for (dr, dc) in [(상, 하, 좌, 우)]:
            nr = r + dr
            nc = c + dc
            
            if nr, nc가 grid 범위 안이고
               grid[nr][nc] == 1 (통과 가능) 이고
               visited[nr][nc] == False 이면:
                dfs_recursive(nr, nc)    # 재귀 호출
    
    dfs_recursive(start_r, start_c)
```

## 설명

1. **초기화**
   * `visited`: 같은 칸을 여러 번 방문하는 것을 막기 위해 필요
   * **재귀 함수** 형태로 구현 (스택 자동 활용)

2. **재귀 시작**
   * 현재 위치를 방문 처리
   * 목표 조건 확인 (문제마다 다름)

3. **깊이 우선 탐색**
   * 한 방향으로 **끝까지** 들어가기
   * 막다른 길에 도달하면 **되돌아오기** (백트래킹)

4. **이웃 탐색**
   * 상하좌우 4방향을 돌며 새 좌표 계산
   * 조건 체크 순서:
     ① 범위 안?
     ② 통과 가능한 칸?
     ③ 방문 안 했나?

5. **재귀 호출**
   * 조건 통과하면 그 위치에서 **다시 DFS 시작**
   * 재귀가 끝나면 자동으로 **이전 위치로 복귀**

## BFS vs DFS 비교

| 구분 | BFS | DFS |
|------|-----|-----|
| **탐색 방식** | 넓게 퍼져나가며 (레벨별) | 깊게 들어가며 (한 방향 끝까지) |
| **자료구조** | 큐 (Queue) | 스택 (재귀 또는 명시적 스택) |
| **구현** | `queue.popleft()` + `while` | 재귀 함수 |
| **최단거리** | ✅ 보장 | ❌ 보장 안 됨 |
| **메모리** | 많은 메모리 (큐 크기) | 적은 메모리 (재귀 스택) |
| **시간복잡도** | O(V + E) | O(V + E) |

## DFS가 유용한 경우

1. **경로 탐색**: 모든 가능한 경로 찾기
2. **사이클 탐지**: 그래프에서 순환 구조 찾기
3. **연결 요소**: 섬의 개수, 연결된 컴포넌트
4. **백트래킹**: N-Queens, 순열/조합 문제
5. **위상 정렬**: 의존 관계가 있는 작업 순서

## 기억할 것

* **재귀 = 자동 스택**: 함수 호출 스택이 DFS 스택 역할
* **방문 처리**: 재귀 호출 **전에** `visited[r][c] = True`
* **백트래킹**: 재귀가 끝나면 자동으로 이전 상태로 복귀
* **깊이 우선**: 한 방향으로 계속 파고들어가는 특성
* **"들어가고 -> 처리하고 -> 되돌아오고"를 반복**

## DFS 구현 패턴

### 재귀 방식 (일반적)
```python
def dfs(r, c):
    visited[r][c] = True
    
    # 처리 로직
    
    for dr, dc in dirs:
        nr, nc = r + dr, c + dc
        if in_range(nr, nc) and passable(nr, nc) and not visited[nr][nc]:
            dfs(nr, nc)  # 재귀 호출
```

### 명시적 스택 방식
```python
def dfs(start_r, start_c):
    stack = [(start_r, start_c)]
    
    while stack:
        r, c = stack.pop()
        if visited[r][c]:
            continue
            
        visited[r][c] = True
        
        for dr, dc in dirs:
            nr, nc = r + dr, c + dc
            if in_range(nr, nc) and passable(nr, nc) and not visited[nr][nc]:
                stack.append((nr, nc))
```

## 2차원 배열 생성
```python
visited = [[False] * m for _ in range(n)]
# n = 행(세로) 개수, m = 열(가로) 개수
# visited[행][열] 로 접근
```

## 🔍 DFS의 핵심 아이디어

### 깊이 우선 = "한 우물만 파기"
- 한 방향으로 **끝까지** 가본다
- 더 이상 갈 곳이 없으면 **되돌아온다**
- 다른 방향으로 **다시 끝까지** 가본다

### 재귀의 자동 백트래킹
- 재귀 함수가 끝나면 **자동으로 이전 위치**로
- 스택 관리를 **컴퓨터가 자동**으로 해줌
- "들어갔다 나오는" 과정이 **자연스럽게** 구현됨

### 핵심 정리
**DFS = "깊게 파고들어가서 모든 가능성 탐색" → 완전 탐색에 적합**
