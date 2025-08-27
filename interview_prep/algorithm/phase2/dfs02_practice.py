'''
LeetCode - Combination Sum

문제 이해:
- candidates는 유니크한 숫자들로 이루어진 배열
- 더해서 target이 되는 숫자들의 조합 구하기
- candidates[i]는 여러번 사용될 수 있음

제한사항:
- 1 <= candidates.length <= 30
- 2 <= candidates[i] <= 40
- All elements of candidates are distinct.
- 1 <= target <= 40

백트래킹이 필요한 이유:
- 모든 조합을 시도하고, 조건에 만족하는 것들만 모으기 위해서

핵심 흐름:
1. 숫자를 하나 선택
2. target - 그 숫자
3. 같은 위치부터 다시 시도 (같은 숫자 재사용 가능)
4. target이 0이 되면 성공
5. 안 되면 돌아가서 다른 숫자 시도

수도코드:
function combinationSum(candidates, target):
    result = []
    current_path = []
    
    function backtrack(start_index, remaining_target):
        if remaining_target == 0:
            result에 current_path.copy() 추가
            return
        
        if remaining_target < 0:
            return  # 목표 초과
        
        for i = start_index to candidates 배열 길이-1:
            current_path에 candidates[i] 추가     # 선택
            backtrack(i, remaining_target - candidates[i])  # 재귀 (i부터 재시작)
            current_path에서 마지막 요소 제거      # 되돌리기
    
    backtrack(0, target)  # 인덱스 0부터, 전체 target으로 시작
    return result

시간 복잡도: O(N^(T/M))
- N: candidates 배열 크기
- T: target 값
- M: candidates의 최소값
- 각 단계에서 N개 선택지, 최대 T/M 깊이까지 탐색
-> 지수적 시간 복잡도를 가짐

공간 복잡도: O(T/M)
- 재귀 호출 스택 깊이가 최대 T/M
- path 배열도 최대 길이 T/M
-> 재귀 깊이에 비례
'''
def combinationSum(candidates, target):
    result = []
    
    def backtrack(start, path, remaining):
        if remaining == 0:
            # path[:] 복사하는 이유:
            # path는 계속 변하는 값
            # 정답 찾은 순간의 값을 고정해서 저장해야 함
            # 복사 안 하면 나중에 path 바뀔 때 result도 함께 바뀜
            result.append(path[:])  # 복사본 저장
            return
        
        if remaining < 0:
            return
        
        for i in range(start, len(candidates)):
            path.append(candidates[i])                      # 선택
            backtrack(i, path, remaining - candidates[i])   # 재귀
            path.pop()                                      # 되돌리기 (path 변함)
    
    backtrack(0, [], target)
    return result



print(combinationSum([2, 3], 5))
# 예상: [[2, 3]]
