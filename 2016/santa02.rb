#! /usr/bin/env ruby

instructions = Array.new()

keyPad = [[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]]

keyPad2 = [[' ', ' ', '1', ' ', ' '],
           [' ', '2', '3', '4', ' '],
           ['5', '6', '7', '8', '9'],
           [' ', 'A', 'B', 'C', ' '],
           [' ', ' ', 'D', ' ', ' ']]

def getCode(instructions, keyPad)
    x = 1
    y = 1
    endCode = ""

    instructions.each do |instruction|
        for i in 0...instruction.length do 
            if instruction[i] == 'U'
                if y > 0
                    y -= 1
                end
            elsif instruction[i] == 'L'
                if x > 0
                    x -= 1
                end
            elsif instruction[i] == 'R'
                if x < 2
                    x += 1
                end
            elsif instruction[i] == 'D'
                if y < 2
                    y += 1
                end
            end
        end
        endCode << keyPad[y][x].to_s
    end

    puts endCode
end

def getCode2(instructions, keyPad)
    x = 1
    y = 1
    endCode = ""

    instructions.each do |instruction|
        for i in 0...instruction.length do 
            if instruction[i] == 'U'
                if (y > 0 && keyPad[y-1][x] != ' ')
                    y -= 1
                end
            elsif instruction[i] == 'L'
                if (x > 0 && keyPad[y][x-1] != ' ')
                    x -= 1
                end
            elsif instruction[i] == 'R'
                if (x < 4 && keyPad[y][x+1] != ' ')
                    x += 1
                end
            elsif instruction[i] == 'D'
                if (y < 4 && keyPad[y+1][x] != ' ')
                    y += 1
                end
            end
        end
        endCode << keyPad[y][x].to_s
    end

    puts endCode
end

ARGF.each_line do |line|
    instructions.push(line.chomp)    
end

getCode(instructions, keyPad)
getCode2(instructions, keyPad2)
