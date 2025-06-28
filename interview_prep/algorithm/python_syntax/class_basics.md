# 클래스 기초

## self 키워드

### self란?
- self = "이 클래스의 인스턴스 자기 자신"
- 클래스 매서드의 첫 번째 매개변수로 사용
- 인스턴스 변수와 메서드에 접근할 때 필요

### 기본 사용법
```python
class MedianFinder:
    def __init__(self):
        self.nums = []  # "내가 가진 nums 리스트"
    
    def addNum(self, num):
        self.nums.append(num)  # "내 리스트에" 추가
    
    def findMedian(self):
        n = len(self.nums)  # "내 리스트의" 길이
```

### 왜 self가 필요한가?
```python
# self 없으면 오류
def findMedian(self):
    n = len(nums)   # nums가 뭔지 모름

# self로 명확하게 지정
def findMedian(self):
    n = len(self.nums)

```

### 인스턴스 예시
```python
mf1 = MedianFinder()
mf2 = MedianFinder()

mf1.addNum(1)    # mf1의 nums에만 추가
mf2.addNum(100)  # mf2의 nums에만 추가

print(mf1.nums)  # [1]
print(mf2.nums)  # [100]
```

## init 메서드

### 생성자 역할
- 객체가 생성될 때 자동으로 호출되는 메서드
- 인스턴스 변수 초기화에 사용

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

# 객체 생성 시 __init__ 자동 호출
person1 = Person("Minji", 25)
print(person1.name)
```

### 매개변수 활용
```python
class MedianFinder:
    def __init__(self):
        self.nums = []  # 빈 리스트로 초기화
        self.count = 0  # 개수 추적용
```

## 인스턴스 변수 vs 클래스 변수

### 인스턴스 변수
- 각 객체마다 따로 가지는 변수
- `self.변수명`으로 정의

```python
class Student:
    def __init__(self, name):
        self.name = name    # 인스턴스 변수
        self.scores = []    # 각자 다른 점수 리스트

s1 = Student("Minji")
s2 = Student("Hanni")
# s1.scores와 s2.scores는 별개
```

### 클래스 변수
- 모든 객체가 공유하는 변수
- 클래스 내부에 직접 정의

```python
class Student:
    school_name = "ABC고등학교" # 클래스 변수 (모두 공유)

    def __init__(self, name):
        self.name = name    # 인스턴스 변수 (각자)

s1 = Student("Minji")
s2 = Student("Hanni")
print(s1.school_name)  # "ABC고등학교"
print(s2.school_name)  # "ABC고등학교" (같은 값)
```

## 매서드 정의와 호출

### 메서드 정의

```python
class Calculator:
    def __init__(self):
        self.result = 0
    
    def add(self, num):        # 인스턴스 메서드
        self.result += num
        return self.result
    
    def reset(self):           # 매개변수 없는 메서드
        self.result = 0
```

### 메서드 호출

```python
calc = Calculator()
calc.add(5)      # calc.result = 5
calc.add(3)      # calc.result = 8
calc.reset()     # calc.result = 0
```

## 자주 하는 실수들

### 1. self 빠뜨리기

```python
# ❌ 잘못된 코드
class MedianFinder:
    def findMedian():  # self 빠짐!
        return len(nums)  # nums가 뭔지 모름
```

### 2. self 없이 변수 접근

```python
# ❌ 잘못된 코드
def addNum(self, num):
    nums.append(num)  # self.nums가 맞음

# ✅ 올바른 코드
def addNum(self, num):
    self.nums.append(num)
```

### 3. 인스턴스 변수 초기화 안하기

```python
# ❌ __init__에서 초기화 안함
class MedianFinder:
    def addNum(self, num):
        self.nums.append(num)  # nums가 없어서 오류!

# ✅ __init__에서 초기화
class MedianFinder:
    def __init__(self):
        self.nums = []  # 미리 초기화!
```

## 면접에서 자주 나오는 패턴

### 1. 상태 유지 클래스

```python
class MovingAverage:
    def __init__(self, size):
        self.size = size
        self.queue = []
    
    def next(self, val):
        self.queue.append(val)

        # 최근 size개만 유지
        if len(self.queue) > self.size:
            self.queue.pop(0)
        return sum(self.queue) / len(self.queue)
```

### 2. 데이터 구조 구현

```python
class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        return self.items.pop()

    def is_empty(self):
        return len(self.items) == 0
```
