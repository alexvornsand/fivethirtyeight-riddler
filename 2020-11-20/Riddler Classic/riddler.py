# https://fivethirtyeight.com/features/can-you-pass-the-cranberry-sauce/

import random

def findLastToSauce(k):
    seats = list(range(k))
    wantsSauce = list(range(1, k))
    hasSauce = 0
    while(len(wantsSauce) > 1):
        passTo = random.sample([-1,1], 1)[0]
        nextSauce = (hasSauce + passTo) % k
        hasSauce = seats[nextSauce]
        if(hasSauce in wantsSauce):
            wantsSauce.remove(hasSauce)
    return wantsSauce[0]

def findLastToSauceRepeatedly(n, k):
    lastToSauce = []
    for i in range(n):
        lastToSauce.append(findLastToSauce(k))
    return [lastToSauce.count(i) / n for i in range(k)]

findLastToSauceRepeatedly(100000, 9)
