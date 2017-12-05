#! /usr/bin/env ruby

input = []
input2 = []

def getSteps(arr)
    steps = 0
    i = 0
    len = arr.length
    while(true) 
        # find next index
        jump = arr[i]
        # update value at current index
        arr[i] += 1
        # update current index
        i = jump + i
        steps += 1
        if(i >= len)
            return steps
        end
    end
end

def getSteps2(arr)
    steps = 0
    i = 0
    len = arr.length
    while(true) 
        # find next index
        jump = arr[i]
        # update value at current index
        if(arr[i] >= 3)
            arr[i] -= 1
        else
            arr[i] += 1
        end
        # update current index
        i = jump + i
        steps += 1
        if(i >= len)
            return steps
        end
    end
end

ARGF.each_line do |line|
    num = line.chomp.to_i
    input << num
    input2 << num
end

puts getSteps(input)
puts getSteps2(input2)
