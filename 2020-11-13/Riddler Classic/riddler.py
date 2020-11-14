# https://fivethirtyeight.com/features/can-you-snatch-defeat-from-the-jaws-of-victory/

from math import comb
import numpy as np
import matplotlib.pyplot as plt

def probOfWin(n,w, N = 101, W = 51):
    # n is the number of throws so far
    # w is the number of wins so far
    R = N - n # remaining throws
    D = W - w # needed to win
    if(w > n): # check if possible to win
        return np.nan
    elif(R < D):
        return 0
    elif(w >= 51):
        return 1.00
    else:
        pOfOutcome = []
        for r in range(D, R + 1):
            pOfOutcome.append(comb(R, r) / (2 ** R))
        return sum(pOfOutcome)


probOfWin(4,3,5,3)

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
        if probWinMatrix[r][c] >= 0.99 and probWinMatrix[r][c] < 1.00:
            probStateMatrix[r][c] = probOfState(c,r)
plt.imshow(probStateMatrix, cmap = 'hot', interpolation = 'nearest')

p99 = probStateMatrix.sum(axis = 0)
q99 = 1 - p99

probOf99Chance = []
for i in range(102):
    p = p99[i] * np.prod(q99[:i])
    probOf99Chance.append(p)

probOf99Chance
