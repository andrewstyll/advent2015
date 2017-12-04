#! /usr/bin/env ruby

# returns largest odd square root <= to input value
def findLargestOddRoot(n)
    x = n
    while(true) do 
        y = ((x + (n/x).to_i)/2).to_i
        if(y >= x)
            if(x%2 == 0)
                x = x-1
            end
            return x
        end
        x = y
    end
end

def getSteps(num)
    steps = 0
    root = findLargestOddRoot(num)
    if(num/root != root)
        root += 2
    end

    # tells us number of steps in to take
    steps += root/2 - (1/2)

    # calculate the number of steps to take around, towards center
    square = root*root
    for i in 1..4 do 
        minVal = square - (root-1)*i
        if minVal < num
            maxVal = minVal + (root-1)
            centerVal = (maxVal + minVal)/2
            stepsAround = centerVal - num
            
            if(stepsAround < 0)
                stepsAround *= -1
            end
            steps += stepsAround
            break
        end
    end
    return steps
end

def sumAround(spiral, i, j)
    total = spiral[i+1][j] + spiral[i-1][j] + spiral[i][j+1] + spiral[i][j-1]
    total += spiral[i+1][j+1] + spiral[i+1][j-1] + spiral[i-1][j-1] + spiral[i-1][j+1]
    return total
end

SPIRAL_LEN = 21
def getSteps2(num)
    spiral = Array.new(SPIRAL_LEN){ Array.new(SPIRAL_LEN){ 0 } } 
    #starting point is center of spiral
    startIndex = (SPIRAL_LEN - 1)/2
    i = startIndex
    j = startIndex
    spiral[i][j] = 1
    j+=1
    while(j < SPIRAL_LEN-2 && i < SPIRAL_LEN-2 && j > 0 && i > 0)
        # move up
        while(spiral[i][j-1] != 0)
            n = sumAround(spiral, i, j)
            if(n > num)
                return n
            else 
                spiral[i][j] = n
                i -= 1
            end
        end
        # move left
        while(spiral[i+1][j] != 0)
            n = sumAround(spiral, i, j)
            if(n > num)
                return n
            else
                spiral[i][j] = n
                j -= 1
            end
        end
        # move down
        while(spiral[i][j+1] != 0)
            n = sumAround(spiral, i, j)
            if(n > num)
                return n
            else
                spiral[i][j] = n
                i += 1
            end
        end
        while(spiral[i-1][j] != 0)
            n = sumAround(spiral, i, j)
            if(n > num)
                return n
            else
                spiral[i][j] = n
                j += 1
            end
        end
    end
    return "ran out of space"
end

ARGF.each_line do |line|
    num = line.chomp.to_i
    #puts getSteps(num)
    puts getSteps2(num)
end
