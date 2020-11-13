# https://fivethirtyeight.com/features/can-you-eat-all-the-chocolates/
import random

# define a function that eats the bag of chocolates a single time and return the last
# chocolate in the bag
def eatAllTheChocolates():
    bagOfChocolates = ['d', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'm', 'm']
    lastChocolate = ''
    while(len(bagOfChocolates) > 1):
        if(lastChocolate == ''):
            chocolate = random.sample(bagOfChocolates, 1)[0]
            bagOfChocolates.remove(chocolate)
            lastChocolate = chocolate
        else:
            chocolate = random.sample(bagOfChocolates, 1)[0]
            if chocolate == lastChocolate:
                bagOfChocolates.remove(chocolate)
            else:
                lastChocolate = ''
    return bagOfChocolates[0]

# simulate eating the bag of chocolates 10 million times, and then find the portion
# of the time that the last chocolate is milk
def eatAllTheChocolatesOverAndOverAndOver():
    results = []
    for i in range(10000000):
        results.append(eatAllTheChocolates())
    return results.count('m') / len(results)

eatAllTheChocolatesOverandOverAndOver()
