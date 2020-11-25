# https://fivethirtyeight.com/features/can-you-pass-the-cranberry-sauce/

using StatsBase

function findLastToSauce(k)
    seats = [0:(k-1);]
    wantsSauce = [1:(k-1);]
    hasSauce = 0
    while length(wantsSauce) > 1
        passTo = sample([-1,1])
        hasSauce = mod(hasSauce + passTo, k)
        if hasSauce in wantsSauce
            deleteat!(wantsSauce, wantsSauce .== hasSauce)
        end
    end
    return wantsSauce
end

function findLastToSauceRepeatedly(n, k)
    x = [findLastToSauce(k) for i in 1:n]
    return proportionmap(x)
end

findLastToSauceRepeatedly(100000, 20)
