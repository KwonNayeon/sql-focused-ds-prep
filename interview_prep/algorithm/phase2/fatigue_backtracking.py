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
전역변수: answer = 0

function dfs(현재피로도, 탐험수, visited배열):
    answer = max(answer, 탐험수)  # 현재까지 최대값 갱신
    
    for i in range(던전개수):
        if not visited[i] and 현재피로도 >= dungeons[i][0]:
            visited[i] = True              # 방문 표시
            dfs(현재피로도 - dungeons[i][1], 탐험수 + 1, visited)
            visited[i] = False             # 백트래킹 (상태 복구)

main:
    visited = [False] * len(dungeons)
    dfs(k, 0, visited)
    return answer

시간 복잡도: 
- 

공간 복잡도: 
- 
'''
