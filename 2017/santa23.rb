#! /usr/bin/env ruby

instructions = []
registers = Hash.new

registers2 = Hash.new

def checkRegisters(registers, reg, debug)
    if(!registers.has_key?(reg))
        if(!debug && reg == "a")
            registers[reg] = 1
        else
            registers[reg] = 0
        end

    end
end

def checkInput(registers, val, debug)
    if(val != nil)
        if(val.match(/[-]?\d+/))
            # value is a number
            return val.to_i
        else
            # value is a register
            checkRegisters(registers, val, debug)            
            return registers[val]
        end
    else
        return nil
    end
end

def runInstructions(instructions, registers, debug)
    i = 0
    mulCount = 0
    indexArray = []
    between = 0
    while(i < instructions.length)
        indexArray << i
        inst = instructions[i]
        cmd = inst[0]
        reg = inst[1]
        val = checkInput(registers, inst[2], debug)
        #reg = checkInput(registers, inst[1], debug)
        checkRegisters(registers, reg, debug)
         
        if(cmd == "set")
            registers[reg] = val
        elsif(cmd == "sub")
            registers[reg] -= val
        elsif(cmd == "mul")
            registers[reg] *= val
            mulCount+=1
        elsif(cmd == "jnz")
            #puts "jnz #{inst} #{reg}"
            reg = checkInput(registers, reg, debug)
            
            if(reg != 0)
                i+=val-1
            end
        end
        i+=1
        between+=1
        if(debug && i == 15)
            puts "15 called"
        end
        if(false && (debug && i == 19))
            #registers["d"] = 107899
            #registers["f"] = 1
            dumpReg(registers)
            puts "#{indexArray[indexArray.length-200..indexArray.length-1]}"

            instructions.each_with_index do |inst, index|
                if(index > 10 && index < 20 && index != 15)
                    puts "#{inst}" 
                end
            end
            puts "Between20: #{between}"
            between = 0
        end
    end

    if(debug)
        return "mulCount: #{mulCount}"
    else
        return "reg[h]: #{registers["h"]}"
    end
end

def dumpReg(registers)
    puts "\nRegisters: "
    registers.each do |k, v|
        puts "#{k}: #{v}"
    end
end

ARGF.each_line do |line|
    instructions << line.chomp.split(' ')
end

puts runInstructions(instructions, registers, true)
#puts runInstructions(instructions, registers2, false)
