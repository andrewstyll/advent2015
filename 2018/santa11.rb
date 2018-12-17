#! /usr/bin/env ruby

input = -1
GRID_HEIGHT = 300

def findPowerLevel(x, y, sI) 
    rackId = x+10
    pL = rackId*y
    pL += sI
    pL *= rackId

    if(pL < 100)
        return -5
    else
        return ((pL/100)%10).floor-5
    end
end

def traverseGrid(input)
    
    grid = Array.new(GRID_HEIGHT) { Array.new(GRID_HEIGHT, 0)}

    maxLevel = 0
    maxX = -1
    maxY = -1

    (0...GRID_HEIGHT).each do |i|
        (0...GRID_HEIGHT).each do |j|
            grid[i][j] = findPowerLevel(j+1, i+1, input)

            if(i >= 2 && j >= 2)
                sum = grid[i][j] + grid[i-1][j] + grid[i-2][j] + grid[i][j-1] + grid[i-1][j-1] + grid[i-2][j-1] + grid[i][j-2] + grid[i-1][j-2] + grid[i-2][j-2]
                if((maxX == -1 && maxY == -1) || sum > maxLevel)
                    maxLevel = sum
                    maxX = j-2+1
                    maxY = i-2+1
                end
            end
        end
    end

    return "Max power level at grid starting at #{maxX},#{maxY}: #{maxLevel}"
end

def traverseGrid2(input)
    
    grid = Array.new(GRID_HEIGHT) { Array.new(GRID_HEIGHT, 0) }
    singleLevels = Array.new(GRID_HEIGHT) { Array.new(GRID_HEIGHT, 0) }

    maxLevel = 0
    maxX = -1
    maxY = -1
    maxK = -1

    (1..GRID_HEIGHT).each do |k|
        boundry = GRID_HEIGHT-(k-1)
        (0...boundry).each do |i|
            (0...boundry).each do |j|
                if(k == 1)
                    grid[i][j] = findPowerLevel(j+1, i+1, input)
                    singleLevels[i][j] = grid[i][j]
                else
                    (0...k).each do |l|
                        grid[i][j] += singleLevels[i+l][j+k-1]
                        grid[i][j] += singleLevels[i+k-1][j+l]
                    end
                    grid[i][j] -= singleLevels[i+k-1][j+k-1]
                end
                if(grid[i][j] > maxLevel)
                    maxLevel = grid[i][j]
                    maxX = j+1
                    maxY = i+1
                    maxK = k
                end
            end
        end
    end

    return "Max power level at grid starting at #{maxX},#{maxY},#{maxK}: #{maxLevel}"
end

ARGF.each_line do |line|
    input = line.chomp.to_i
end

puts traverseGrid(input)
puts traverseGrid2(input)
