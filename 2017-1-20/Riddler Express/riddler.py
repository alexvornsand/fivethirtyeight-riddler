# https://fivethirtyeight.com/features/can-you-time-the-stoplight-just-right/

import random

def playCoinGame():
    aHeads = []
    bHeads = []
    turn = 0
    while sum(aHeads) < 10 and sum(bHeads) < 10:
        if turn % 2 == 0:
            aHeads.append(random.sample([0,1], 1)[0])
            turn += 1
        else:
            bHeads.append(random.sample([0,1], 1)[0])
            turn += 1
    if sum(aHeads) == 10:
        return(1)
    else:
        return(0)

def playCoinGameRepeatedly():
    results = [playCoinGame() for i in range(10000000)]
    return sum(results) / len(results)

playCoinGameRepeatedly()
