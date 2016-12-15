#! /usr/bin/env ruby

#I need registers

registers = { "a" => 0, 
              "b" => 0, 
              "c" => 0, 
              "d" => 0 }
registers2 = { "a" => 0, 
               "b" => 0, 
               "c" => 1, 
               "d" => 0 }
instructions = Array.new

def readVal(val, registers)
    if(val !~ /[a-d]/)
        return val.to_i
    else
        return registers[val]
    end
end

def run(instructions, registers)
    i = 0 
    while(i < instructions.length)
        instruction = instructions[i]
        if(instruction[0] == "cpy")
            registers[instruction[2]] = readVal(instruction[1], registers)
            i += 1
        elsif(instruction[0] == "inc")
            registers[instruction[1]] += 1
            i += 1
        elsif(instruction[0] == "dec")
            registers[instruction[1]] -= 1
            i += 1
        elsif(instruction[0] == "jnz")
            if(registers[instruction[1]] != 0)
                i += instruction[2].to_i
            else
                i += 1
            end
        end
    end
    puts "a: #{registers["a"]}, b: #{registers["b"]}, c: #{registers["c"]}, d: #{registers["d"]}"
end

ARGF.each_line do |line|
    instructions.push(line.chomp.split(' '))    
end

run(instructions, registers)
run(instructions, registers2)
