#! /usr/bin/env ruby

input = Array.new
$states = Hash.new

def getMaxIndex(arr)
    maxIndex = 0
    maxValue = 0
    arr.each_with_index do |n, i|
        if n > maxValue
            maxIndex = i
            maxValue = n
        end
    end
    return maxIndex
end

def addState(arr)
    newArr = Array.new
    arr.each do |e|
        newArr<< e.clone
    end
    $states.each do |key, value|
        $states[key] = value+1
    end
    $states[newArr] = 1
end

def getSeqCount(input)
    numChanges = 0
    len = input.length
    
    loop do
        addState(input)
        # find index with maximum value
        maxIndex = getMaxIndex(input)
         
        maxValue = input[maxIndex]
        input[maxIndex] = 0
        base = maxValue/len
        extra = maxValue%len

        input.each_with_index do |n, i|
            input[i] += base
            if(maxIndex+extra-(len-1) > i)
                input[i] += 1
            elsif(i > maxIndex && i <= maxIndex+extra)
                input[i] += 1
            end
        end
        numChanges+=1
        if($states.key?(input))
            break
        end
    end
    return "#{numChanges} #{$states[input]}"
end

ARGF.each_line do |line|
    input = line.chomp.split.map(&:to_i)
end

puts getSeqCount(input)
