# Combination

# Solution 1: backtracking

def combine(n, k):
    """
    조합(Combination) (n개 중 k개 뽑기, 백트래킹)
    - 시간복잡도: O(nCk * k)
    """
    result = []
    def backtrack(path, start):
        if len(path) == k:
            result.append(path)
            return
        for i in range(start, n+1):
            backtrack(path + [i], i+1)
    backtrack([], 1)
    return result


# Solution 2: 내장함수 사용
from itertools import combinations

def combine(n, k):
    """
    조합(Combination) (n개 중 k개 뽑기, itertools 사용)
    - 시간복잡도: O(nCk)
    """
    return list(combinations(range(1, n+1), k))


# 자주 사용되는 itertools 함수들
from itertools import combinations     # 조합 (순서 상관없이 선택)
from itertools import permutations     # 순열 (순서가 중요한 선택)
from itertools import product          # 데카르트 곱 (중복 허용한 모든 조합)
from itertools import combinations_with_replacement  # 중복 허용한 조합

# 1부터 4까지 숫자 중 2개를 선택하는 모든 조합
list(combinations(range(1, 5), 2))  # [(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]

# 1부터 3까지 숫자의 모든 순열
list(permutations(range(1, 4)))  # [(1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)]