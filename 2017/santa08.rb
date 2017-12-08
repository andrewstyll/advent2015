#! /usr/bin/env ruby

registers = Hash.new
input = Array.new

def modRegisters(input, registers)

    maxOverall = 0

    input.each do |instruction|
        target = instruction[0]
        modifier = instruction[1]
        value = instruction[2].to_i
        compare = instruction[4]
        operator = instruction[5]
        opVal = instruction[6]
        
        if(!registers.has_key?(target))
            registers[target] = 0
        end
        if(!registers.has_key?(compare))
            registers[compare] = 0
        end
        
        operation = registers[compare].to_s + operator + opVal
        if(eval(operation))
            if(modifier == "inc")
                registers[target] += value
            else
                registers[target] -= value
            end
            if(registers[target] > maxOverall)
                maxOverall = registers[target]
            end
        end
    end
    puts "maxOverall: #{maxOverall}"
    return findMaxVal(registers)
end

def findMaxVal(registers)
    maxVal = 0
    registers.each do |key, value|
        if(value > maxVal)
            maxVal = value
        end
    end
    return maxVal
end

ARGF.each_line do |line|
    input << line.chomp.split(' ')
end

puts modRegisters(input, registers)
