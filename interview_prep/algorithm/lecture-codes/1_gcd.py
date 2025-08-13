# 최대공약수(GCD) 구하기
# 참고: https://www.youtube.com/watch?v=M2mcJvmYpWY (강의 학습 후 풀이)

# 1. 덧셈 버전
def gcd_add(a, b):
    while a != 0 and b != 0:
        if a > b:
            a -= b
        else:
            b -= a
    return (a + b)

# 2. 나머지 버전
def gcd_mod(a, b):
    while a !=0 and b != 0:
        if a > b:
            a %= b
        else:
            b %= a
    return (a + b)


# 3. 재귀 버전
def gcd_recursive(a, b):
    if a == 0:
        return b
    return gcd(b, a % b)