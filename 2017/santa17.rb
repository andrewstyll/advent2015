#! /usr/bin/env ruby

INSERTIONS = 2017
INSERTIONS2 = 50000000
#INSERTIONS = 5
steps = 0

def getNum(steps)
    array = []
    currentPos = 0
    0.upto(INSERTIONS) do |n|
        if(array.length == 0)
            array << 0
            currentPos = 0
        else
            # I will add n values
            # figure out next location
            currentPos = (currentPos+steps)%array.length + 1
            if(currentPos >= array.length)
                array << n
            else
                tmp = array[0..currentPos-1] << n
                tmp2 = array[currentPos..array.length]
                array = tmp + tmp2
            end
        end
    end
    return "#{array[currentPos+1]}"
end

def getNum2(steps)
    currentPos = 0
    arrayLen = 0
    beforeZero = 0
    0.upto(INSERTIONS2) do |n|
        if(arrayLen == 0)
            currentPos = 0
        else
            # I will add n values
            # figure out next location
            currentPos = (currentPos+steps)%arrayLen + 1
            if(currentPos == 1)
                beforeZero = n
            end
        end
        arrayLen += 1
    end
    return "#{beforeZero}"
end

ARGF.each_line do |line|
    steps = line.chomp.to_i
end

puts getNum(steps)
puts getNum2(steps)
