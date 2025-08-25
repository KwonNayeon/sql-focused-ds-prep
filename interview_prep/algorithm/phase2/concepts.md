# 알고리즘 & Python 개념 정리

## 용어 구분

### Edge Case vs Base Case
- **Edge Case**: 특수한 상황, 미리 처리 필요
- **Base Case**: 정상적인 종료 조건

## Python 중첩 함수 (Nested Functions)

### 중첩 함수의 장점
```python
def solution(maps):
    n, m = len(maps), len(maps[0])
    visited = [[False] * m for _ in range(n)]
    
    # 바깥 변수(maps, n, m, visited) 자동 접근 가능
    def in_range(r, c):
        return 0 <= r < n and 0 <= c < m  # n, m 자동 사용
    
    def passable(r, c):
        return maps[r][c] == 1  # maps 자동 사용
    
    def bfs(start_r, start_c):
        # visited, maps 등 모든 바깥 변수 접근 가능
        visited[start_r][start_c] = True
        # ...
```

### 중첩 함수 vs 일반 함수
| 중첩 함수 | 일반 함수 |
|----------|----------|
| `in_range(r, c)` | `in_range(r, c, n, m)` |
| `passable(r, c)` | `passable(grid, r, c)` |
| 바깥 변수 자동 접근 | 매개변수로 전달 필요 |

### 언제 사용하면 좋을까?
- **알고리즘 문제**: helper 함수들이 많은 공통 변수 사용할 때
- **코드 정리**: 관련 함수들을 하나로 묶고 싶을 때  
- **매개변수 줄이기**: 반복적인 매개변수 전달 피하고 싶을 때