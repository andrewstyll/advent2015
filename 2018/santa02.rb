#! /usr/bin/env ruby

input = Array.new

def countDifs(string1, string2)
    chars1 = string1.chars
    chars2 = string2.chars

    return chars1.zip(chars2).select {|a,b| a == b}
end

def getBoxes(input)
    ret = ""
    input.each do |i|
        input.each do |j|
            if(i != j)
                diffs = countDifs(i,j)
                if(diffs.length == i.length-1)
                    ret = diffs.map {|a,b| a}     
                end
            end
        end
    end
    return ret.join
end

def getChecksum(input)
    twoTimes = 0
    threeTimes = 0

    input.each do |id|
        twoMatch = false
        threeMatch = false
        letterCount = Array.new(26, 0)

        id.each_char do |c|
            letterCount[c.ord-'a'.ord] += 1
        end

        letterCount.each do |index|
            if(!twoMatch && index == 2)
                twoMatch = true
                twoTimes+=1
            end
            if(!threeMatch && index == 3)
                threeMatch = true
                threeTimes+=1
            end
        end
    end

    return twoTimes*threeTimes
end

ARGF.each_line do |line|
    input << line.chomp
end

puts getChecksum(input)
puts getBoxes(input)
