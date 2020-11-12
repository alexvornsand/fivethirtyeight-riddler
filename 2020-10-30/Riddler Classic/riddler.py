# https://fivethirtyeight.com/features/beware-the-hot-pumpkin/

# find the lowest n such that n mod 61 = 19, n mod 60 = 32,
# and n mod 59 = 1
n = 1
while(True):
    if n % 61 == 19 and n % 60 == 32 and n % 59 == 1:
        print(n)
        break
    n += 1

# sequentially eliminate seats from the game until only one remains
def hotPumpkin(n):
  seats = list(range(1,62))
  while(len(seats) > 1):
      i = n % len(seats) - 1
      seats = seats[i:] + seats[:i]
      seats.pop(0)
  return seats[0]

hotPumpkin(136232)

# loop through values until we find one where hotPumpkin(n) is 1
n = 1
while(True):
    if hotPumpkin(n) == 1:
        print(n)
        break
    n += 1
