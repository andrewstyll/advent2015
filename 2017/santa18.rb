#! /usr/bin/env ruby

instructions = []
registers = Hash.new

registersA = Hash.new
registersB = Hash.new

def checkRegisters(registers, reg)
    if(!registers.has_key?(reg))
        registers[reg] = 0
    end
end

def checkInput(registers, val)
    if(val != nil)
        if(val.match(/[-]?\d+/))
            # value is a number
            return val.to_i
        else
            # value is a register
            checkRegisters(registers, val)            
            return registers[val]
        end
    else
        return nil
    end
end

def runInstructions(instructions, registers)
    i = 0
    soundLastPlayed = nil
    while(i < instructions.length)
        inst = instructions[i]
        cmd = inst[0]
        reg = inst[1]
        val = checkInput(registers, inst[2])
        checkRegisters(registers, reg)
        
        if(cmd == "snd")
            # play sound of freq in reg
            reg = checkInput(registers, reg)
            soundLastPlayed = reg
        elsif(cmd == "set")
            registers[reg] = val
        elsif(cmd == "add")
            registers[reg] += val
        elsif(cmd == "mul")
            registers[reg] *= val
        elsif(cmd == "mod")
            registers[reg] = registers[reg]%val
        elsif(cmd == "rcv")
            reg = checkInput(registers, reg)
            if(reg != 0)
                return "#{soundLastPlayed}"
            end
        elsif(cmd == "jgz")
            reg = checkInput(registers, reg)
            if(reg > 0)
                i+=val-1
            end
        end
        i+=1
    end
end

def runInstructions2(instructions, registers, index, send, rcv)
    i = index
    while(i < instructions.length)
        inst = instructions[i]
        cmd = inst[0]
        reg = inst[1]
        val = checkInput(registers, inst[2])
        
        if(cmd == "snd")
            reg = checkInput(registers, reg)
            send << reg
        elsif(cmd == "set")
            registers[reg] = val
        elsif(cmd == "add")
            registers[reg] += val
        elsif(cmd == "mul")
            registers[reg] *= val
        elsif(cmd == "mod")
            registers[reg] = registers[reg]%val
        elsif(cmd == "rcv")
            if(rcv.length != 0)
                registers[reg] = rcv.shift
            else
                return i
            end
        elsif(cmd == "jgz")
            reg = checkInput(registers, reg)
            if(reg > 0)
                i+=val-1
            end
        end
        i+=1
    end
end

def runInParallel(inst, regA, regB)
    regA["p"] = 0
    regB["p"] = 1

    sendFromA = []
    sendFromB = []

    indexA = 0
    indexB = 0

    sendFromBCount = 0

    loop do
        # run A until hits rcv, return things sent and instruction index
        indexA = runInstructions2(inst, regA, indexA, sendFromA, sendFromB)
        
        countB = []
        # run B until hits rcv, return things sent and instruction index
        indexB = runInstructions2(inst, regB, indexB, countB, sendFromA)
        sendFromB += countB
        sendFromBCount += countB.length
        if(sendFromA.length == 0 && sendFromB.length == 0)
            return sendFromBCount
        end
    end
end

ARGF.each_line do |line|
    instructions << line.chomp.split(' ')
end

puts runInstructions(instructions, registers)
puts runInParallel(instructions, registersA, registersB)
