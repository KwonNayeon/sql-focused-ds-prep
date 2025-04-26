# LeetCode 문제

# 383. Ransom Note

# Solution 1
# Example
# Counter(ransomNote) = Counter({'a': 2})
# Counter(magazine) = Counter({'a': 1, 'b': 1})
# Counter(ransomNote) - Counter(magazine) = Counter({'a': 1})   # 'b'는 ransomNote에는 없기 때문에, 결과에 아예 안 나옴.
def can_construct(ransomNote: str, magazine: str) -> bool:
    """
    Determine if ransomNote can be constructed from magazine.
    Time Complexity: O(n) where n is the length of magazine + ransomNote
    Space Complexity: O(k) where k is the size of the character set
    """
    from collections import Counter
    return not (Counter(ransomNote) - Counter(magazine))

# Solution 2
class Solution:
    def canConstruct(self, ransomNote: str, magazine: str) -> bool:
        # 1. magazine의 각 글자 개수 세기
        char_count = {}
        for char in magazine:
            if char in char_count:
                char_count[char] += 1
            else:
                char_count[char] = 1

        # 2. ransomNote의 각 글자가 magazine에 충분히 있는지 확인
        for char in ransomNote:
            # magazine에 글자가 아예 없거나, magazine에 있긴 하지만 이미 다 써서 더 이상 남아있지 않은 경우
            if char not in char_count or char_count[char] == 0:
                return False
            char_count[char] -= 1

        return True

"""
리스트(List)와 딕셔너리(Dictionary) 접근 방식 차이, 그리고 defaultdict 사용법

1. 리스트(List) 접근 방식
- 리스트는 값에 '인덱스(숫자)'로 접근.
- 예시:
    my_list = [10, 20, 30]
    print(my_list[0])  # 10 (0번 위치 값)
- 리스트는 순서가 중요하며, 인덱스는 0부터 시작.
- 값을 추가할 때는 my_list.append(값)을 사용.

2. 딕셔너리(Dictionary) 접근 방식
- 딕셔너리는 '키(key)'로 값을 저장하고, 키로 접근.
- 예시:
    my_dict = {'a': 1, 'b': 2}
    print(my_dict['a'])  # 1 ('a'라는 키의 값)
- 딕셔너리는 순서보다 '키'가 중요.
- 값을 추가/수정할 때는 my_dict[키] = 값 형식을 사용.
- 존재하지 않는 키를 바로 접근하면 KeyError가 발생.

3. defaultdict 사용법 (collections 모듈)
- defaultdict는 딕셔너리의 한 종류로, '기본값'을 자동으로 지정.
- 일반 딕셔너리는 없는 키에 접근하면 에러가 나지만,
  defaultdict는 미리 정한 기본값으로 자동 초기화.
- 예시 (기본값이 0인 경우):
    from collections import defaultdict
    count = defaultdict(int)
    count['apple'] += 1   # 'apple'이 없으면 0으로 시작해서 1이 됨
    print(count['apple']) # 1

- 예시 (기본값이 빈 리스트인 경우):
    from collections import defaultdict
    group = defaultdict(list)
    group['fruits'].append('apple')
    print(group['fruits']) # ['apple']
"""

