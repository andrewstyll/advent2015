#! /usr/bin/env ruby

def getDecomLength(string)
    index = 0
    length = 0

    puts string
    while index < string.length
        if(string[index] == '(')
            tmpString = ""
            index += 1
            while(string[index] != ')')
                tmpString << string[index]
                index += 1
            end
            data = tmpString.split('x')
            numChars = data[0].to_i
            numTimes = data[1].to_i
            #length += numChars*numTimes
            length += numTimes*getDecomLength(string[index+1..index+numChars])
            index += numChars
        else
            length += 1
        end
        index += 1
        #puts "#{string[index]} index #{index} length #{length}"
    end
    return length
end

ARGF.each_line do |line|
    puts getDecomLength(line.chomp)
end
