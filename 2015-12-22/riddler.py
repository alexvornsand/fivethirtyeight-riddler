import random

def waitForDinner():
    a = random.sample((1,2,3,4,5), 1)[0]
    b = random.sample((1,2,3,4,5), 1)[0]
    while(a != b):
        if(a > b):
            b += random.sample((1,2,3,4,5), 1)[0]
        else:
            a += random.sample((1,2,3,4,5), 1)[0]
    return a

def waitForDinnerRepeatedly():
    waits = []
    for i in range(10000000):
        waits.append(waitForDinner())
    return sum(waits) / len(waits)

waitForDinnerRepeatedly()
