#! /usr/bin/env ruby

#ARRAY_HEIGHT = 3
#ARRAY_WIDTH = 7

ARRAY_HEIGHT = 6
ARRAY_WIDTH = 50

screen = Array.new(ARRAY_HEIGHT) {Array.new(ARRAY_WIDTH, '.')}
instructions = Array.new

def makeRect(screen, instruction)
    puts "make rect x:#{instruction[1]} y:#{instruction[2]}"   
    (0...instruction[2]).each do |y|
        (0...instruction[1]).each do |x|
            screen[y][x] = '#'
        end
    end
end

def rotateRow(screen, instruction)
    y = instruction[1]
    count = instruction[2]
    puts "rotate row #{y} y:#{count}"   
    while(count > 0)
        tmp = screen[y][screen[0].length-1]
        (screen[0].length-1).downto(0) do |x|
            screen[y][x] = (x > 0) ? screen[y][x-1] : tmp
        end
        count -= 1
    end
end

def rotateColumn(screen, instruction)
    x = instruction[1]
    count = instruction[2]
    puts "rotate column #{x} x:#{count}"   
    while(count > 0)
        tmp = screen[screen.length-1][x]
        (screen.length-1).downto(0) do |y|
            screen[y][x] = (y > 0) ? screen[y-1][x] : tmp
        end
        count -= 1
    end
end

def doInstructions(screen, instructions)
    pixelCount = 0
    
    instructions.each do |i|
        if(i[0] == "mr")
            makeRect(screen, i)
        elsif(i[0] == "rr")
            rotateRow(screen, i)
        elsif(i[0] == "rc")
            rotateColumn(screen, i)
        end
    
        screen.each do |s|
            puts "#{s.join}"
        end
        puts ""
    end

    puts screen.map { |row| row.count('#') }.inject(:+)
end

ARGF.each_line do |line|
    input = line.chomp.split(' ')
    if(input[0] == "rect")
        mini = input[1].split('x')
        instructions << ["mr", mini[0].to_i, mini[1].to_i]
    elsif(input[1] == "row")
        mini = input[2].split('=')
        instructions << ["rr", mini[1].to_i, input[4].to_i]
    elsif(input[1] == "column")
        mini = input[2].split('=')
        instructions << ["rc", mini[1].to_i, input[4].to_i]
    end
end

doInstructions(screen, instructions)
