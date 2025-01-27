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
