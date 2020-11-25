# https://fivethirtyeight.com/features/can-you-slay-the-puzzle-of-the-monsters-gems/

using StatsBase

function collectGems()
    rare = 0
    uncommon = 0
    common = 0
    while min(rare, uncommon, common) == 0
        newGem = sample(["common", "uncommon", "rare"], Weights([3, 2, 1]))
        if newGem == "common"
            common += 1
        elseif newGem == "uncommon"
            uncommon += 1
        else
            rare += 1
        end
    end
    return common
end

function collectGemsRepeatedly()
    return mean([collectGems() for i in 1:10000000])
end

collectGemsRepeatedly()
