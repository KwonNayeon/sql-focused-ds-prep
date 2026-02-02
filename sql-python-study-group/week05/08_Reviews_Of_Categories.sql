-- Reviews of Categories
-- unnest(): 배열을 행으로 펼치는 함수
-- string_to_array(): 문자열을 배열로 변환하는 함수

select
    -- 'Food;Restaurant;Bar' 같은 문자열을
    -- 1. string_to_array()로 ['Food', 'Restaurant', 'Bar'] 배열로 만들고
    -- 2. unnest()로 각 요소를 별도의 행으로 펼침
    -- 결과: 원래 1개 행 → 3개 행으로 확장
    unnest(string_to_array(categories, ';')) as category,
    
    -- review_count는 펼쳐진 각 행마다 동일한 값으로 복제됨
    review_count
from yelp_business;

-- 예시:
-- 입력 데이터:
-- business_id | categories              | review_count
-- 1           | 'Food;Restaurant;Bar'   | 100
-- 2           | 'Shopping;Retail'       | 50

-- 출력 결과:
-- category    | review_count
-- Food        | 100  ← business_id 1에서 생성
-- Restaurant  | 100  ← business_id 1에서 생성
-- Bar         | 100  ← business_id 1에서 생성
-- Shopping    | 50   ← business_id 2에서 생성
-- Retail      | 50   ← business_id 2에서 생성
