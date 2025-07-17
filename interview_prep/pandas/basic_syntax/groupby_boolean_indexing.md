# Pandas GroupBy & Boolean 인덱싱 요약

## 핵심 패턴
```python
# 그룹화 -> 집계 -> 필터링
result = df.groupby('칼럼').집계함수()
filtered = result[result >= 조건]
```

## 자주 쓰는 것들

### 날짜별 고유 사용자 수
```python
df.groupby('activity_date')['user_id'].nunique().reset_index()
```

### 클래스별 학생 수가 5명 이상
```python
courses.groupby('class').size()
result = result[result >= 5].reset_index()
```

## Boolean 인덱싱
```python
numbers = [1, 7, 3, 8, 2]
condition = number >= 5   # [False, True, False, True, False]
filtered = numbers[condition]   # [7, 8]
```

## 기억할 것
- `nunique()`: 중복 제거 후 개수
- `size()`: 각 그룹의 행 개수
- `result[result >= 5]`: True인 것만 선택
- SQL: WHERE(개별행) vs HAVING(그룹)