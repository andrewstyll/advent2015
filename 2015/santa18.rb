#! /usr/bin/env ruby

CYCLENUM = 100

lights = Array.new

def setCorners(lights)
    lights[0][0] = "#"
    lights[0][-1] = "#"
    lights[-1][0] = "#"
    lights[-1][-1] = "#"

    return lights
end

def cycleLights(lights)
   
    # i can't edit the current grids values.... then what happens if i take a step down or some shit...
    # make a state grid that records the status of all relevant pieces next to a square
    lightData = Array.new(lights.length) {Array.new(lights[0].length, 0)}
    
    
    (0...lights.length).each do |y|
        (0...lights[0].length).each do |x|
            #store all data about the current state of the lights
            #do this by adding a 1 to all neighbors
            if(lights[y][x] != "#") 
                next
            end
            if(y-1 >= 0) #north
                lightData[y-1][x] += 1
            end
            if(y-1 >= 0 && x+1 < lights[0].length) #ne
                lightData[y-1][x+1] += 1
            end
            if(x+1 < lights[0].length) #e
                lightData[y][x+1] += 1
            end
            if(y+1 < lights.length && x+1 < lights[0].length) #se
                lightData[y+1][x+1] += 1
            end
            if(y+1 < lights.length) #s
                lightData[y+1][x] += 1
            end
            if(y+1 < lights.length  && x-1 >= 0) #sw
                lightData[y+1][x-1] += 1
            end
            if(x-1 >= 0) #w
                lightData[y][x-1] += 1
            end
            if(y-1 >= 0 && x-1 >= 0) #nw
                lightData[y-1][x-1] += 1
            end
        end
    end
    
    (0...lights.length).each do |y|
        (0...lights[0].length).each do |x|
            if(lights[y][x] == "#" && (lightData[y][x] != 2 && lightData[y][x] != 3) )
                lights[y][x] = "."
            elsif(lights[y][x] == "." && (lightData[y][x] == 3))
                lights[y][x] = "#"
            end
        end
    end
    
    return lights
end

ARGF.each_line do |line|
    lights.push(line.chomp.chars.to_a)
end

lights = setCorners(lights)
#puts "initial"
#(0...lights.length).each do |y|
#    print lights[y]
#    puts ""
#end
#puts ""

for i in 0...CYCLENUM do 
    lights = cycleLights(lights)
    lights = setCorners(lights)

    #(0...lights.length).each do |y|
    #    print lights[y]
    #    puts ""
    #end
    #puts ""
end

sum = 0
lights.each do |y|
    sum += y.map!{|i| i == "#" ? 1 : 0}.inject(:+)
end
puts sum
