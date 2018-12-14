#! /usr/bin/env ruby

positions = []
velocities = []

class String
    def black; "\e[30m#{self}\e[0m" end
    def green; "\e[32m#{self}\e[0m" end
    def red; "\e[31m#{self}\e[0m" end
end

def printPositions(positions, yMin, yMax, xMin, xMax)
    

    array = Array.new(yMax-yMin+1) {Array.new(xMax-xMin+1, ".")}
    positions.each do |position|
        x = position[0] - (xMin).abs
        y = position[1] - (yMin).abs
        array[y][x] = "#"
    end

    puts "================= New Print ========================="
    array.each do |row|
        row.each do |val|
            if(val == ".")
                print "# ".black
            elsif(val == "#")
                print "# ".green
            end
        end
        puts "\n"
    end
    puts "================= End Print ========================="
end

def drawStars(positions, velocities)
    
    i = 0
    loop do
        xMin = nil
        xMax = nil
        yMin = nil
        yMax = nil

        positions.each_with_index do |position, index|
            position[0] = velocities[index][0] + position[0]
            position[1] = velocities[index][1] + position[1]
            
            x = position[0]
            y = position[1]
            if(xMin == nil || x < xMin)
                xMin = x
            end
            if(xMax == nil || x > xMax)
                xMax = x
            end
            if(yMin == nil || y < yMin)
                yMin = y
            end
            if(yMax == nil || y > yMax)
                yMax = y

            end
        end
        i += 1
        if((yMax-yMin).abs < 10)
            printPositions(positions, yMin, yMax, xMin, xMax)
            puts "Found in #{i} ticks".red
            break
        end
    end
end

ARGF.each_line do |line|
    input = line.chomp.split(/[<>]/)
    position = input[1].split(',').map {|n| n.to_i}
    velocity = input[3].split(',').map {|n| n.to_i}
    positions << position
    velocities << velocity
end

drawStars(positions, velocities)

