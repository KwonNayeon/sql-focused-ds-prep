import numpy as np

def batch_iterator(X, y=None, batch_size=64):
	# Your code here
	result = []

    for i in range(0, len(X), batch_size):
        X_batch = X[i:i+batch_size]

        if y is not None:
            y_batch = y[i:i+batch_size]
            result.append([X_batch.tolist(), y_batch.tolist()])
        else:
            result.append(X_batch.tolist())
    return result

'''
=== 코드 동작 설명 ===

1. batch_size의 의미:
   - 한 번에 몇 개씩 묶어서 처리할지 결정
   - batch_size=2 → 2개씩 묶음
   - 머신러닝에서 메모리 효율을 위해 전체 데이터를 작은 단위로 나눔

2. range(0, len(X), batch_size) 동작:
   - 0부터 시작해서 batch_size만큼 점프
   - 예: len(X)=5, batch_size=2
   - i = 0, 2, 4 순서로 반복

3. X[i:i+batch_size] 슬라이싱:
   - i번째부터 batch_size개만큼 가져옴
   - 첫 번째: X[0:2] → 인덱스 0, 1
   - 두 번째: X[2:4] → 인덱스 2, 3
   - 세 번째: X[4:6] → 인덱스 4 (1개만 남아도 괜찮음)

4. [X_batch, y_batch] 리스트 구조:
   - 대괄호 []로 X배치와 y배치를 하나로 묶음
   - 이것이 "하나의 배치"
   - 예: [[[1,2], [3,4]], [1, 2]]
          └─────┬─────┘  └──┬──┘
           X 배치(2개)   y 배치(2개)

5. result.append()의 역할:
   - append는 리스트에 요소를 "추가"
   - 각 배치를 result 리스트에 쌓음
   - result = [배치1, 배치2, 배치3, ...]

6. 최종 결과 구조:
   result = [
       [[[1,2], [3,4]], [1, 2]],    # 배치 1: X 2개, y 2개
       [[[5,6], [7,8]], [3, 4]],    # 배치 2: X 2개, y 2개
       [[[9,10]], [5]]              # 배치 3: X 1개, y 1개 (남은 것)
   ]

7. 실제 사용:
   batches = batch_iterator(X, y, batch_size=2)
   
   for batch in batches:
       X_batch = batch[0]  # X 데이터 가져오기
       y_batch = batch[1]  # y 레이블 가져오기
       # 모델 학습에 사용
       model.train(X_batch, y_batch)
'''
