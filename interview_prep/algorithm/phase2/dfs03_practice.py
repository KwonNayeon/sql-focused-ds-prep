'''
LeetCode - N-Queens

문제 이해:
- input: 퀸의 개수(n)
- output: 2D 배열, 각 행은 문자열
- 형태: [["Q..", ".Q.", "..Q"], ...]
- no two queens attack each other
  - 같은 행, 같은 열, 같은 대각선에는 퀸을 놓을 수 없음

제한사항:
- 1 <= n <= 9

백트래킹이 필요한 이유:
- 모든 조합을 시도하고, 조건에 만족하는 것들만 모으기 위해서

수도코드:
1. 빈 solutions 리스트 만들기
2. n x n 보드 초기화 ("."으로 채우기)

3. is_safe 함수:
   - 같은 열 체크
   - 대각선 체크 (2방향)
   - 안전하면 True 리턴

4. backtrack 함수:
   - 만약 모든 행 다 놨으면: 해답에 추가하고 리턴
   - 현재 행의 각 열에 대해:
     * 안전하다면: 퀸 놓고 → 다음 행 호출 → 퀸 빼기

5. backtrack(0) 호출해서 시작
6. solutions 리턴

시간 복잡도: O(N!)
- 각 행마다 가능한 위치가 점점 줄어들어서 N × (N-2) × (N-4) x ... 형태가 됨

공간 복잡도: O(N²)
- N × N 배열, 재귀의 깊이는 최대 N
'''
from typing import List

class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        solutions = []
        board = [["." for _ in range(n)] for _ in range(n)]

        def is_safe(row, col):
            # 같은 열에 퀸이 있는지
            for i in range(row):
                if board[i][col] == "Q":
                    return False

            # 왼쪽 위 대각선
            i, j = row - 1, col - 1
            while i >= 0 and j >= 0:
                if board[i][j] == "Q":
                    return False
                i -= 1
                j -= 1

            # 오른쪽 위 대각선
            i, j = row - 1, col + 1
            while i >= 0 and j < n:
                if board[i][j] == "Q":
                    return False
                i -= 1
                j += 1
            
            return True
        
        def backtrack(row):
            # 만약 모든 행 다 놨으면
            if row == n:
                # 보드를 문자열로 변환하여 추가
                result = []
                for row in board:
                    result.append("".join(row))
                solutions.append(result)
                return

            for col in range(n):
                    if is_safe(row, col):
                        board[row][col] = 'Q'
                        # 다음 행 호출
                        backtrack(row + 1)
                        board[row][col] = "."
        
        backtrack(0)
        return solutions



# 테스트 1: n=1 (1x1 보드)
solution = Solution()
print(solution.solveNQueens(1))
# 예상: [["Q"]]

# 테스트 2: n=2 (불가능한 경우)  
print(solution.solveNQueens(2))
# 예상: [] (해답 없음)

# 테스트 3: n=4 (가장 작은 가능한 경우)
print(solution.solveNQueens(4))
# 예상: 2개의 해답이 나와야 함