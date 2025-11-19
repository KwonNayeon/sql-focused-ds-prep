import math

def softmax(scores: list[float]) -> list[float]:
    # 1. 각 요소의 exp 계산
    probabilities = [math.exp(x) for x in scores]
    
    # 2. exp 값들의 합 계산
    total = sum(probabilities)
    
    # 3. 각 exp 값을 total로 나누기
    probabilities = [p / total for p in probabilities]
    
    return probabilities

# Review Notes:
# 2025-11-19: Softmax 함수는 간단해서 구현하는 건 어렵지 않았음. List comprehension 쓰는 거 연습 필요
