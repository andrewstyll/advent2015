#! /usr/bin/env ruby

require 'set'

instructions = Array.new

def getSum(instructions)
    set = Set.new
    foundDup = false
    sum = 0
    count = 0

    while !foundDup do 
        instructions.each do |num|
            sum += num
            if(set.include?(sum) && !foundDup)
                puts "First duplicate is #{sum}"
                foundDup = true
            else
                set.add(sum)
            end
        end
        count += 1
        if(count == 1) 
            puts "Sum is #{sum}"
        end
    end
end

ARGF.each_line do |line|
    instructions.push(line.chomp.to_i)
end

getSum(instructions)
