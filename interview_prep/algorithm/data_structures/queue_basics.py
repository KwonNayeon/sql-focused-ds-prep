# 큐 기본 동작들

from collections import deque

queue = deque([1, 2, 3, 4])
print(queue)

# popleft(): 맨 앞에서 빼기
x = queue.popleft()
print(x)      # 1 (빼낸 값)
print(queue)  # deque([2, 3, 4]) (남은 큐)

# append(): 맨 뒤에 추가
queue.append(5)
print(queue)  # deque([2, 3, 4, 5])


# 큐 vs 일반 리스트

# 일반 리스트
arr = [1, 2, 3, 4]
arr.pop(0)    # 맨 앞 제거 (느림! O(n))
arr.append(5) # 맨 뒤 추가

# 큐 (deque)
queue = deque([1, 2, 3, 4])
queue.popleft()  # 맨 앞 제거 (빠름! O(1))
queue.append(5)  # 맨 뒤 추가


# 트리 순회에서 사용
queue = deque([root])  # [root]

while queue:
    node = queue.popleft()  # 맨 앞 노드를 꺼냄
    print(node.val)
    
    # 자식들을 뒤에 추가
    if node.left:
        queue.append(node.left)
    if node.right:
        queue.append(node.right)
