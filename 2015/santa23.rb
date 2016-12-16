#! /usr/bin/env ruby

#I need registers

registers = { "a" => 0, 
              "b" => 0 }

registers2 = { "a" => 1, 
              "b" => 0 }

instructions = Array.new

def run(instructions, registers)
    i = 0 
    while(i < instructions.length)
        
        instruction = instructions[i]
        if(instruction[0] == "hlf")
            registers[instruction[1]] = registers[instruction[1]]/2
            i += 1
        elsif(instruction[0] == "tpl")
            registers[instruction[1]] = registers[instruction[1]]*3
            i += 1
        elsif(instruction[0] == "inc")
            registers[instruction[1]] += 1
            i += 1
        elsif(instruction[0] == "jmp")
                i += instruction[1].to_i
        elsif(instruction[0] == "jie")
            if(registers[instruction[1]].to_i%2 == 0)
                i += instruction[2].to_i
            else
                i += 1
            end
        elsif(instruction[0] == "jio")
            if(registers[instruction[1]] == 1)
                i += instruction[2].to_i
            else
                i += 1
            end
        end
    end
    puts "a: #{registers["a"]}, b: #{registers["b"]}"
end

ARGF.each_line do |line|
    instructions.push(line.chomp.split(/[\s,]+/))    
end

puts "#{instructions}"
run(instructions, registers)
run(instructions, registers2)
