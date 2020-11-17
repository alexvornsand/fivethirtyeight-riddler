# https://fivethirtyeight.com/features/will-the-neurotic-basketball-player-make-his-next-free-throw/

import random

def shootFreethrows():
    shots = [1,0]
    for i in range(2,100):
        p = sum(shots) / len(shots)
        shot = random.choices([1,0], weights = [p, 1 - p], k = 1)[0]
        shots.append(shot)
    if(shots[98] == 1):
        return shots[99]

def shootFreethrowsRepeatedly():
    results = []
    for i in range(10000000):
        result = shootFreethrows()
        if(result == 1 or result == 0):
            results.append(result)
    return sum(results) / len(results)

shootFreethrowsRepeatedly()
