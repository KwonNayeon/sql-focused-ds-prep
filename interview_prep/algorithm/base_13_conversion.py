"""
트러블 슈팅:

1. while 조건문
- while num == 0 으로 작성했었는데, 이러면 0일때만 루프가 돌아서 잘못됨
- while num != 0 이어야 숫자가 0이 될 때까지 계속 나누기 진행할 수 있음

2. remainder vs num 변환
- 처음에는 num을 A,B,C로 변환하려 했는데, 실제로는 remainder를 변환해야 함
- num은 다음 나누기를 위해 계속 13으로 나눈 몫이 되어야 하기 때문

3. 결과 저장과 반환
- 처음에는 마지막 remainder만 반환했었음
- 모든 자릿수를 저장하려면 리스트가 필요
- list.append(str(remainder))로 각 자릿수를 문자열로 변환해서 저장
- 마지막에 ''.join(list[::-1])로 뒤집어서 문자열로 합쳐야 함

4. base case 처리
- 입력이 0일 때는 while 루프 전에 처리해야 함
- if num == 0: return '0'을 맨 앞에 추가
"""

def convertToBase13(num):
   if num == 0:  # base case
       return '0'
       
   list = []
   while num != 0:
       remainder = num % 13
       num = num // 13
       
       if remainder > 9:
           if remainder == 10:
               remainder = 'A'
           if remainder == 11:
               remainder = 'B'
           if remainder == 12:
               remainder = 'C'
       list.append(str(remainder))
   
   return ''.join(list[::-1])
