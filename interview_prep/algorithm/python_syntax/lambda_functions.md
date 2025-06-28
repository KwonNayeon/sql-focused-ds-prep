# Lambda 함수 정리

## 기본 문법
```python
lambda x: x.start   # x를 받아서 x.start 반환
```

## 정렬에서 사용
```python
# 시작점 기준 정렬
intervals.sort(key=lambda x: x.start)

# 끝점 기준 정렬
intervals.sort(key=lambda x: x.end)
```

## LeetCode: Meeting Rooms
```python
class interval:
    def __init__(self, start, end):
        self.start = start
        self.end = end

intervals = [Interval(3,5), Interval(1,4), Interval(6,8)]
intervals.sort(key=lambda x: x.start)   # start 기준으로 정렬
```

