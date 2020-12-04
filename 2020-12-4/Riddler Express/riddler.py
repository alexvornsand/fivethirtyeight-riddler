import random

def drawNames(n):
    x = random.sample(range(n), n)
    return all([x[i] != i for i in range(n)])

def drawNamesRepeatedly(n):
    results = []
    for i in range(10000000):
        results.append(drawNames(n))
    return sum(results) / len(results)

drawNamesRepeatedly(5)
