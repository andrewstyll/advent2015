#! /usr/bin/env ruby
require 'set'

inputs = []
xMin = -1
xMax = -1
yMin = -1
yMax = -1

MAX_DISTANCE = 10000

def fillGrid1(coords, xMin, xMax, yMin, yMax, set)

    grid = Array.new(yMax-yMin+1) {Array.new(xMax-xMin+1)}

    (0...grid.length).each do |i|
        (0...grid[0].length).each do |j|
            minIndex = -1
            minTaxi = -1
            coords.each_with_index do |coord, index|
                x = coord[0]-xMin
                y = coord[1]-yMin
                taxi = (j-x).abs + (i-y).abs
                if(minTaxi == -1 || taxi < minTaxi)
                    minTaxi = taxi
                    minIndex = index
                elsif(taxi == minTaxi)
                    minIndex = -1
                end
            end
            grid[i][j] = minIndex
            if(i == 0 || i == grid.length-1 || j == 0 || j == grid[i].length-1)
                set.add(grid[i][j])
            end
        end
    end
    
    return grid
end

def getDangerous(coords, xMin, xMax, yMin, yMax)

    infinite = Set.new()
    grid = fillGrid1(coords, xMin, xMax, yMin, yMax, infinite)
    hash = Hash.new()

    maxArea = 0

    (0...grid.length).each do |i|
        (0...grid[i].length).each do |j|
            if(!infinite.include?(grid[i][j]))
                if(!hash.include?(grid[i][j]))
                    hash[grid[i][j]] = 1
                else
                    hash[grid[i][j]] += 1
                end
                if(hash[grid[i][j]] > maxArea)
                    maxArea = hash[grid[i][j]]
                end
            end
        end
    end
    return maxArea
end

def fillGrid2(coords, xMin, xMax, yMin, yMax)

    grid = Array.new(yMax-yMin+1) {Array.new(xMax-xMin+1)}

    (0...grid.length).each do |i|
        (0...grid[0].length).each do |j|
            taxi = 0
            coords.each_with_index do |coord, index|
                x = coord[0]-xMin
                y = coord[1]-yMin
                taxi += (j-x).abs + (i-y).abs
            end
            grid[i][j] = taxi
        end
    end
    
    return grid
end

def getSafe(coords, xMin, xMax, yMin, yMax)
    grid = fillGrid2(coords, xMin, xMax, yMin, yMax)

    ret = 0
    (0...grid.length).each do |i|
        (0...grid[i].length).each do |j|
            if(grid[i][j] < MAX_DISTANCE)
                ret+=1
            end
        end
    end
    return ret
end

ARGF.each_line do |line|
    input = line.chomp.split(',').map {|n| n.to_i}
    
    x = input[0]
    y = input[1]
    if(xMin == -1 || x < xMin) 
        xMin = x
    end
    if(xMax == -1 || x > xMax)
        xMax = x
    end
    if(yMin == -1 || y < yMin) 
        yMin = y
    end
    if(yMax == -1 || y > yMax)
        yMax = y
    end

    inputs << input
end

puts getDangerous(inputs, xMin, xMax, yMin, yMax)
puts getSafe(inputs, xMin, xMax, yMin, yMax)
