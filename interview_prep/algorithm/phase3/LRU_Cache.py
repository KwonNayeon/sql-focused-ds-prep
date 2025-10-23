'''
목표:
- 가장 단순한 LRU Cache 만들기
- 최근에 접근한 key를 뒤로 보낸다.
- 용량 초과 시, 제일 오래된 key(맨 앞)를 삭제한다.

Time complexity: O(n)
- self.order가 리스트이기 때문
- append(key) → O(1), 리스트 맨 끝에 붙이는 건 빠름.
- remove(key) → O(n), 리스트 안에서 key가 어딨는지 처음부터 끝까지 탐색해야 함.
- 그래서 get()이나 put()이 한 번 호출될 때마다 최악의 경우 key를 찾느라 리스트를 다 돌아야 하니까 O(n)
'''
class LRUCache:

    def __init__(self, capacity: int):
        self.cap = capacity
        self.cache = {}
        self.order = []     # 가장 오래된 게 맨 앞

    def get(self, key: int) -> int:
        # 만약 키가 존재하지 않으면 -1 반환
        if key not in self.cache:
            return -1
        # get() 호출 = 그 key를 방금 사용함 -> 뒤로 보내기
        self.order.remove(key)
        self.order.append(key)
        return self.cache[key]

    def put(self, key: int, value: int) -> None:
        # 만약 키가 존재하면 기존 순서에서 제거
        if key in self.cache:
            self.order.remove(key)
        # 만약 키의 수가 capacity를 넘어서면, 맨 앞(가장 오래된 것) 제거
        elif len(self.cache) >= self.cap:
            oldest = self.order.pop(0)
            # 캐시에서도 삭제
            del self.cache[oldest]

        # 새 값을 저장하고, 최근에 사용된 것을 뒤에 추가
        self.cache[key] = value
        self.order.append(key)
        


# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)



if __name__ == "__main__":
    lru = LRUCache(2)
    lru.put(1, 1)
    lru.put(2, 2)
    print(lru.get(1))  # 1
    lru.put(3, 3)      # 2 제거
    print(lru.get(2))  # -1
    lru.put(4, 4)      # 1 제거
    print(lru.get(1))  # -1
    print(lru.get(3))  # 3
    print(lru.get(4))  # 4
