#! /usr/bin/env ruby

NUMELVES = 3001330
#NUMELVES = 12

def getElves
    highestPower = 2 ** Math.log2(NUMELVES).floor
    return 2*(NUMELVES-highestPower) + 1
end

def getElves2
    highestPower = 3 ** Math.log(NUMELVES, 3).floor
    if(NUMELVES == highestPower)
        return highestPower
    elsif(NUMELVES - highestPower <= highestPower)
        return NUMELVES-highestPower
    else
        return 2*NUMELVES-3*highestPower
    end
end

puts getElves()
puts getElves2()
