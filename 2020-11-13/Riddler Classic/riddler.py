# https://fivethirtyeight.com/features/can-you-snatch-defeat-from-the-jaws-of-victory/

from math import comb

def calculateProbabilityOfWinning(w,N):
    # N is the number of throws remaining
    # w is the number of wins so far
    if(N < 51 - w): # check if possible to win
        return NaN
    elif(w >= 51):
        return 1.00
    else:
        pOfOutcome = []
        for r in range(51 - w, N + 1):
            pOfOutcome.append(comb(N, r) / (2 ** N))
        return sum(pOfOutcome)

calculateProbabilityOfWinning(45, 25)
