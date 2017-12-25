#! /usr/bin/env ruby

map = []
map2 = []

NUM_BURSTS = 10000
NUM_BURSTS2 = 10000000
#NUM_BURSTS2 = 100

class Carrier
    attr_accessor :i, :j, :infected
    def initialize(facing, i, j, partOne)
        @facing = facing
        @i = i 
        @j = j
        @infected = 0
        @partOne = partOne
    end

    def burst(map)
        if(@partOne)
            if(map[@i][@j] == "#")
                # infected
                map[@i][@j] = "."
                turnRight()
            elsif(map[@i][@j] == ".")
                map[@i][@j] = "#"
                @infected+=1
                turnLeft()
            end
        else
            if(map[@i][@j] == ".")
                map[@i][@j] = "W"
                turnLeft()
            elsif(map[@i][@j] == "W")
                @infected+=1
                map[@i][@j] = "#"
                move()
            elsif(map[@i][@j] == "#")
                map[@i][@j] = "F"
                turnRight()
            elsif(map[@i][@j] == "F")
                map[@i][@j] = "."
                reverse()
            end
        end
    end
    
    def reverse
        if(@facing == "U")
            @facing = "D"
        elsif(@facing == "D")
            @facing = "U"
        elsif(@facing == "L")
            @facing = "R"
        elsif(@facing == "R")
            @facing = "L"
        end
        move()
    end

    def turnRight
        if(@facing == "U")
            @facing = "R"
        elsif(@facing == "D")
            @facing = "L"
        elsif(@facing == "L")
            @facing = "U"
        elsif(@facing == "R")
            @facing = "D"
        end
        move()
    end

    def turnLeft
        if(@facing == "U")
            @facing = "L"
        elsif(@facing == "D")
            @facing = "R"
        elsif(@facing == "L")
            @facing = "D"
        elsif(@facing == "R")
            @facing = "U"
        end
        move()
    end

    def move
        if(@facing == "U")
            @i-=1
        elsif(@facing == "D")
            @i+=1
        elsif(@facing == "L")
            @j-=1
        elsif(@facing == "R")
            @j+=1
        end
    end
end

def doCount(map, partOne)
    
    carrier = Carrier.new("U", (map.length+1)/2-1, (map[0].length+1)/2-1, partOne)

    bursts = partOne ? NUM_BURSTS : NUM_BURSTS2

    bursts.times do |n|
        if(carrier.i == 0 || carrier.i == map.length-1 || carrier.j == 0 || carrier.j == map[0].length-1)
            # map needs to be redrawn
            newMap = Array.new(map.length*3) {Array.new(map[0].length*3, ".")}
            i = map.length
            iMax = map.length*2
            while(i < iMax)
                j = map[0].length
                jMax = map[0].length*2
                while(j < jMax)
                    newMap[i][j] = map[i-map.length][j-map[0].length]       
                    j+=1
                end
                i+=1
            end
            carrier.i+=map.length
            carrier.j+=map[0].length
            map = newMap
        end
        carrier.burst(map)
    end
    return "#{carrier.infected}"
end

ARGF.each_line do |line|
    map << line.chomp.split(//)
    map2 << line.chomp.split(//)
end

puts doCount(map, true)
puts doCount(map2, false)
