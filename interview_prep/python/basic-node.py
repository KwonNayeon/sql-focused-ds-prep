"""
관련 문제: 133. Clone Graph from LeetCode
https://leetcode.com/problems/clone-graph/

기본 Node 클래스 구조와 그래프 연결 방법
"""

class Node:
   def __init__(self, val=0):
       self.val = val
       self.neighbors = []

# 노드 생성 및 양방향 연결
node1 = Node(1)
node2 = Node(2)

# 양방향 연결 설정
node1.neighbors.append(node2)
node2.neighbors.append(node1)

# 연결 상태 확인
print(f"node1 → node2: {node1.neighbors[0].val}")  # 출력: node1 → node2: 2
print(f"node2 → node1: {node2.neighbors[0].val}")  # 출력: node2 → node1: 1

# 추가 확인 방법
print(f"node1의 이웃 개수: {len(node1.neighbors)}")
print(f"node2의 이웃 개수: {len(node2.neighbors)}")
