# https://fivethirtyeight.com/features/can-you-snatch-defeat-from-the-jaws-of-victory/

## express

import random

def calcExpWinnings():
    values = [200] * 6 + [400] * 6 + [600] * 6 + [800] * 6 + [1000] * 6
    winnings = []
    for i in range(len(values)):
        winningsSoFar = sum(values[:i])
        if winningsSoFar <= 1000:
            dailyDoubleWinnings = 1000
        else:
            dailyDoubleWinnings = winningsSoFar
        winnings.append(winningsSoFar + dailyDoubleWinnings + sum(values[i+1:]))
    return sum(winnings) / len(winnings)

calcExpWinnings()

def estExpWinnings():
    results = []
    for j in range(10000000):
        values = [200] * 6 + [400] * 6 + [600] * 6 + [800] * 6 + [1000] * 6
        dd = random.sample(list(range(30)), 1)[0]
        winnings = []
        for i in range(30):
            winningsSoFar = sum(winnings)
            if i == dd:
                if winningsSoFar <= 1000:
                    winnings.append(1000)
                else:
                    winnings.append(winningsSoFar)
            else:
                winnings.append(values[i])
        results.append(sum(winnings))
    return sum(results) / len(results)

estExpWinnings()

def calcExpHuntWinnings():
    values = [600] * 30
    winnings = []
    for i in range(len(values)):
        winningsSoFar = sum(values[:i])
        if winningsSoFar <= 1000:
            dailyDoubleWinnings = 1000
        else:
            dailyDoubleWinnings = winningsSoFar
        winnings.append(winningsSoFar + dailyDoubleWinnings + sum(values[i+1:]))
    return sum(winnings) / len(winnings)

calcExpHuntWinnings()

def estExpHuntWinnings():
    results = []
    for j in range(10000000):
        values = [200] * 6 + [400] * 6 + [600] * 6 + [800] * 6 + [1000] * 6
        dd = random.sample(list(range(30)), 1)[0]
        winnings = []
        playOrder = random.sample(list(range(30)), 30)
        for i in playOrder:
            winningsSoFar = sum(winnings)
            if i == dd:
                if winningsSoFar <= 1000:
                    winnings.append(1000)
                else:
                    winnings.append(winningsSoFar)
            else:
                winnings.append(values[i])
        results.append(sum(winnings))
    return sum(results) / len(results)

estExpHuntWinnings()

def calcExpStratWinnings(): # not right
    values = [200] * 6 + [400] * 6 + [600] * 6 + [800] * 6 + [1000] * 6
    dailyDoubleDist = [2, 0, 3, 1, 2, 0, 286, 131, 202, 173, 214, 124, 703, 352, 581, 557, 533, 358, 866, 508, 795, 719, 763, 518, 602, 281, 497, 530, 448, 355]
    playOrder = list(np.argsort(np.array(dailyDoubleDist)))
    winnings = []
    for i in range(30):
        winningsSoFar = sum([values[x] for x in playOrder[:i]])
        if winningsSoFar <= 1000:
            dailyDoubleWinnings = 1000
        else:
            dailyDoubleWinnings = winningsSoFar
        winnings.append((winningsSoFar + dailyDoubleWinnings + sum([values[x] for x in playOrder[i:]])) * dailyDoubleDist[i] / sum(dailyDoubleDist))
    return sum(winnings)

calcExpStratWinnings()

def estExpStratWinnings():
    results = []
    for j in range(10000000):
        values = [200] * 6 + [400] * 6 + [600] * 6 + [800] * 6 + [1000] * 6
        dailyDoubleDist = [2, 0, 3, 1, 2, 0, 286, 131, 202, 173, 214, 124, 703, 352, 581, 557, 533, 358, 866, 508, 795, 719, 763, 518, 602, 281, 497, 530, 448, 355]
        dd = random.choices(list(range(30)), weights = dailyDoubleDist, k = 1)
        playOrder = list(np.argsort(np.array(dailyDoubleDist)))
        winnings = []
        for i in playOrder:
            winningsSoFar = sum(winnings)
            if i == dd:
                if winningsSoFar <= 1000:
                    winnings.append(1000)
                else:
                    winnings.append(winningsSoFar)
            else:
                winnings.append(values[i])
        results.append(sum(winnings))
    return sum(results) / len(results)

estExpStratWinnings()

## classic
from math import comb
import numpy as np
import matplotlib.pyplot as plt

def probOfWin(n,w):
    # n is the number of throws so far
    # w is the number of wins so far
    R = 101 - n # remaining throws
    N = 51 - w # needed to win
    if(w > n): # check if possible to win
        return np.nan
    elif(R < N):
        return 0
    elif(w >= 51):
        return 1.00
    else:
        pOfOutcome = []
        for r in range(N, R + 1):
            pOfOutcome.append(comb(R, r) / (2 ** R))
        return sum(pOfOutcome)

def probOfState(n,w):
    # n is the number of throws so far
    # w is the number of wins so far
    if(w > n): # check if possible to win
        return np.nan
    else:
        return comb(n, w) / (2 ** n)

probWinMatrix = np.zeros((102,102))
for W in range(102):
    for n in range(102):
        probWinMatrix[n][W] = probOfWin(W,n)
plt.imshow(probWinMatrix, cmap = 'hot', interpolation = 'nearest')

probStateMatrix = np.zeros((102,102))
for r in range(102):
    for c in range(102):
        if probWinMatrix[r][c] >= 0.99:
            probStateMatrix[r][c] = probOfState(c,r)
plt.imshow(probStateMatrix, cmap = 'hot', interpolation = 'nearest')

p99 = probStateMatrix.sum(axis = 0)
q99 = 1 - p99

probOf99Chance = []
for i in range(102):
    p = p99[i] * np.prod(q99[:i])
    probOf99Chance.append(p)

probOf99Chance
np.sum(probOf99Chance)

probWinMatrix
