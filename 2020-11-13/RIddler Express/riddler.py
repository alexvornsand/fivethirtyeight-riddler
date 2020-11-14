# https://fivethirtyeight.com/features/can-you-snatch-defeat-from-the-jaws-of-victory/

import random
import numpy as np

# loop through every position on the board (1-30) and calculate the winnings
# one would achieve by winning every question, in which the daily double was
# position i and average the results
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

# simulate the game with the daily double placed randomly and the order fixed
# (1-30) 10,000,000 times
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

# loop through every position on the board (1-30) where each question's value
# is the expected value of a qusetion being chosen at random ($600), and
# average the results
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

# simulate playing randomly 10,000,000 times
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

# loop through every position on the board (1-30) in ascending order of proba-
# bility of being the daily double, to maximize expected return. Calculate the
# winnings with the daily double at each position, and weight by likelihood to
# get expected value
def calcExpStratWinnings(): # not right
    values = [200] * 6 + [400] * 6 + [600] * 6 + [800] * 6 + [1000] * 6
    dailyDoubleDist = [2, 0, 3, 1, 2, 0, 286, 131, 202, 173, 214, 124, 703, 352, 581, 557, 533, 358, 866, 508, 795, 719, 763, 518, 602, 281, 497, 530, 448, 355]
    playOrder = list(np.argsort(np.array(dailyDoubleDist)))
    roundWinnings = []
    for i in playOrder:
        qWinnings = []
        for j in playOrder:
            winningsSoFar = sum(qWinnings)
            if j == i:
                if winningsSoFar <= 1000:
                    qWinnings.append(1000)
                else:
                    qWinnings.append(winningsSoFar)
            else:
                qWinnings.append(values[j])
        expWinnings = sum(qWinnings) * dailyDoubleDist[i] / sum(dailyDoubleDist)
        roundWinnings.append(expWinnings)
    return sum(roundWinnings)

calcExpStratWinnings()

# simulate the above strategy 10,000,000 times
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
