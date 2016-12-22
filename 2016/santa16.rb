#! /usr/bin/env ruby

INPUT = 11101000110010100
DISKSIZE = 272
DISKSIZE2 = 35651584

def calcChecksum(state)
    checkSum = state
    loop do
        newCheckSum = ""
        (0...checkSum.length).step(2) do |i|
            if(checkSum[i] == checkSum[i+1])
                newCheckSum << '1'
            else
                newCheckSum << '0'
            end
        end
        checkSum = newCheckSum
        break if (checkSum.length%2 == 1)
    end
    return checkSum
end

def fillDisk(state, size)
    while(state.length < size)
        b = Array.new(state.length*2+1)
        (0...state.length).each do |i|
            b[i] = state[i]
            #b[state.length*2 - i] = ((b[i] == '0') ? '1' : '0')
        end
        b[state.length] = '0'
        state = b
    end
    newState = state[0...size]
    return calcChecksum(newState)
end

puts fillDisk(INPUT.to_s, DISKSIZE)
puts fillDisk(INPUT.to_s, DISKSIZE2)
