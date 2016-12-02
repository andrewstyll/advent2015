#! /usr/bin/env ruby

directions = []

N = 0
E = 1
S = 2
W = 3

def getDistance(directions)
    #north and east are positive
    northSouth = 0
    eastWest = 0
    currentDir = N
    
    visited = []

    directions.each do |instruction|
        distance = instruction[1].to_i
        if(instruction[0] == 'R')
            currentDir = (currentDir+1)%4
        else
            currentDir = (currentDir-1)%4
        end
       
        # i need to track all the little movements tooo............ grumble grumble
        for i in 0...distance do
            case currentDir
            when N
                northSouth += 1
                #puts "moving #{distance} blocks North [#{eastWest}, #{northSouth}]"
            when E
                eastWest += 1
                #puts "moving #{distance} blocks East [#{eastWest}, #{northSouth}]"
            when S
                northSouth -= 1
                #puts "moving #{distance} blocks South [#{eastWest}, #{northSouth}]"
            else W
                eastWest -= 1
                #puts "moving #{distance} blocks West [#{eastWest}, #{northSouth}]"
            end

            if(visited.include?([eastWest, northSouth]))
                puts "duplicate at #{eastWest.abs + northSouth.abs}"
            else
                visited << [eastWest, northSouth]
            end
        end
    end
    return eastWest.abs + northSouth.abs 
end

ARGF.each_line do |line|
    input = line.chomp.split(', ')
   
    input.each do |char|
        directions << [char[0], char[1..-1]]
    end
end
puts getDistance(directions)
