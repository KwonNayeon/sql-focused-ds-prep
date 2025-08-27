'''
프로그래머스 - 피로도

조건 & 제한사항:
- k는 1 이상 5,000 이하인 자연수입니다.
- dungeons의 세로 길이(즉, 던전의 개수)는 1 이상 8 이하입니다.
  - dungeons의 가로 길이는 2 입니다.
  - dungeons의 각 행은 각 던전의 ["최소 필요 피로도", "소모 피로도"] 입니다.
  - "최소 필요 피로도"는 항상 "소모 피로도"보다 크거나 같습니다.
  - "최소 필요 피로도"와 "소모 피로도"는 1 이상 1,000 이하인 자연수입니다.
  - 서로 다른 던전의 ["최소 필요 피로도", "소모 피로도"]가 서로 같을 수 있습니다.

수도코드:
1. from itertools import permutations

2. 최대 탐험 던전 수 = 0

3. 던전들의 모든 순열에 대해:
   - 현재 피로도 = k
   - 탐험한 던전 수 = 0
   
   - 각 던전을 순서대로 확인:
     - if 현재 피로도 >= 최소 필요 피로도:
       - 현재 피로도 -= 소모 피로도
       - 탐험한 던전 수 += 1
     - else:
       - break (더 이상 탐험 불가)
   
   - 최대값 갱신: max(최대 탐험 던전 수, 탐험한 던전 수)

4. return 최대 탐험 던전 수

시간 복잡도: O(N! × N)
- N개 던전의 모든 순열(N!)을 만들고, 각 순열마다 N개의 던전을 체크함

공간 복잡도: O(N!)
- 모든 순열을 메모리에 생성함
'''
from itertools import permutations
def solution(k, dungeons):
    
    max_d = 0
    
    for perm in permutations(dungeons):
        cur_k = k
        cur_d = 0
        
        for i, j in perm:
            if cur_k >= i:
                cur_k -= j
                cur_d += 1
            else:
                break
                
        max_d = max(max_d, cur_d)
    
    return max_d
