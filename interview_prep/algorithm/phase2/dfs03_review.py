def solveNQueens(n):
    solutions = []
    board = [["." for _ in range(n)] for _ in range(n)]

    def is_safe(row, col):
        for i in range(row):
            if board[i][col] == "Q":
                return False
            
        i, j = row-1, col-1
        while i >= 0 and j >= 0:
            if board[i][j] == "Q":
                return False
            i -= 1
            j -= 1

        i, j = row-1, col+1
        while i >= 0 and j < n:
            if board[i][j] == "Q":
                return False
            i -= 1
            j += 1

        return True
    
    def backtrack(row):
        if row == n:
            result = []
            for row in board:
                result.append("".join(row))
            solutions.append(result)
            return
        
        for col in range(n):
            if is_safe(row, col):
                board[row][col] = "Q"
                backtrack(row + 1)
                board[row][col] = "."

    backtrack(0)
    return solutions



# 테스트 1: n=1 (1x1 보드)
print(solveNQueens(1))
# 예상: [["Q"]]

# 테스트 2: n=2 (불가능한 경우)  
print(solveNQueens(2))
# 예상: [] (해답 없음)

# 테스트 3: n=4 (가장 작은 가능한 경우)
print(solveNQueens(4))
# 예상: 2개의 해답이 나와야 함
