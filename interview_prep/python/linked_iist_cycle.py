"""
Linked List Cycle

- Rabbit(토끼): 두 칸씩 점프!
- Turtle(거북이): 한 칸씩 천천히 이동!

1. 둘 다 출발선(리스트의 head)에서 시작.
2. Rabbit은 두 칸씩, Turtle은 한 칸씩 앞으로 이동.
   (코드: turtle = turtle.next, rabbit = rabbit.next.next)
3. 만약 트랙이 '원형(사이클)'이라면,
   빠른 Rabbit이 언젠가 Turtle을 따라잡게 됨.
4. 만약 트랙이 '직선(사이클 없음)'이라면,
   Rabbit이 먼저 결승선(None)에 도착해서 Turtle과 만날 일이 없음.

즉,
- Rabbit과 Turtle이 만난다 → 사이클 있음(True)
- Rabbit이 먼저 끝에 도달한다 → 사이클 없음(False)

- Time Complexity: O(n) where n is the number of nodes
- Space Complexity: O(1)
"""

def hasCycle(head):
    turtle = head
    rabbit = head

    """
    "rabbit and rabbit.next" means both the current node and the next node exist,
    so it's safe for the rabbit to jump two steps forward.

    If either is missing, we stop the loop.
    """
    while rabbit and rabbit.next:    # rabbit이 아직 None이 아니고, rabbit.next도 None이 아닐 때만 반복
        turtle = turtle.next         # 🐢 한 칸
        rabbit = rabbit.next.next    # 🐇 두 칸
        if turtle == rabbit:
            return True              # 만났다! 사이클 있음
    return False                     # 끝까지 갔는데 못 만났음, 사이클 없음


# self 이해하기
class Person:
    def __init__(self, name):
        self.name = name  # self는 이 객체 자신을 의미

    def say_hello(self):
        print("Hello, my name is", self.name)

p = Person("Alice")
p.say_hello()
