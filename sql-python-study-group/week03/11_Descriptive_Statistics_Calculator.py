import numpy as np
from collections import Counter

def descriptive_statistics(data):
    # Your code here
    sorted_data = sorted(data)
    n = len(data)

    # mean
    mean = sum(data) / n

    # median
    if n % 2 == 1:
        median = sorted_data[n//2]
    else:
        median = (sorted_data[n//2-1] + sorted_data[n//2]) / 2
    
    # mode
    # 딕셔너리 만들기
    count = Counter(data)
    # 많이 등장한 순서대로 정렬 후 값 가져오기
    mode = count.most_common(1)[0][0]

    # variance
    variance = sum((x - mean)**2 for x in data) / n

    # std
    std_dev = variance ** 0.5

    # percentiles
    percentiles = [
        np.percentile(data, 25),
        np.percentile(data, 50),
        np.percentile(data, 75)
    ]

    iqr = percentiles[2] - percentiles[0]

    stats_dict = {
        "mean": mean,
        "median": median,
        "mode": mode,
        "variance": np.round(variance,4),
        "standard_deviation": np.round(std_dev,4),
        "25th_percentile": percentiles[0],
        "50th_percentile": percentiles[1],
        "75th_percentile": percentiles[2],
        "interquartile_range": iqr
    }
    return stats_dict
