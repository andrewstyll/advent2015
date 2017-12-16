#! /usr/bin/env ruby

MAX_VALUE=256
GRID_SIZE=128

grid = Array.new

def hash(lengths, list, hash = nil)

    currentPos = 0
    skipSize = 0

    if(hash != nil)
        currentPos = hash[:currentPos]
        skipSize = hash[:skipSize]
    end

    # reverse order of #{length} elements in list starting at currentPos
    lengths.each do |l|
        i = currentPos
        j = currentPos+l-1
        numSteps = (l-1)/2
        
        if(j >= list.length)
            j = j%list.length
        end
        
        while(numSteps >= 0)
            if(i >= list.length) 
                i = 0
            end
            if(j < 0)
                j = list.length-1
            end

            tmp = list[i]
            list[i] = list[j]
            list[j] = tmp
            j-=1
            i+=1
            
            numSteps -= 1
        end
         
        currentPos += (l+skipSize)
        if(currentPos >= list.length)
            currentPos = currentPos%list.length
        end
        skipSize+=1
    end

    if(hash != nil)
        hash[:currentPos] = currentPos
        hash[:skipSize] = skipSize
    end
end

def hash2(input, list)
    [17, 31, 73, 47, 23].each do |n|
        input << n
    end
   
    denseHash = []
    outString = ""

    tmpHash = Hash.new
    tmpHash[:currentPos] = 0
    tmpHash[:skipSize] = 0

    # list is what is being modified.
    64.times do
        hash(input, list, tmpHash)
    end
    # CORRECT ABOVE HERE

    list.each_slice(16) {|range|
        denseHash << range.inject{|xor, n| xor^n}
    }

    denseHash.each do |e|
        #outString << sprintf("%02x", e)
        outString << sprintf("%08b", e)
    end

    return "#{outString}"
end

def mapInput(input, grid)
    maxCount = 0
    (0...GRID_SIZE).each do |n|
        list = []
        (0...MAX_VALUE).each do |n|
            list << n
        end
        
        inputString = input + "-" + n.to_s
        inputString = inputString.split(//).map{|n| n.ord}
        retString = hash2(inputString, list)
        
        maxCount += retString.count("1")

        retString.gsub!"1", "#"
        grid << retString.split(//)
    end
    return maxCount
end

def tracePath(grid)
    regionCount = 0

    grid.each_with_index do |row, y|
        row.each_with_index do |e, x|
            if(e == "#")
                regionCount+=1
                #start line tracing
                agenda = [[y, x]]
                while(agenda.length != 0)
                    newAgenda = []
                    agenda.each do |coord|
                        i = coord[0]
                        j = coord[1]
                        if(i+1 < grid.length && grid[i+1][j] == "#")
                            newAgenda << [i+1, j]     
                        end
                        if(i-1 >= 0 && grid[i-1][j] == "#")
                            newAgenda << [i-1, j]     
                        end
                        if(j+1 < grid[i].length && grid[i][j+1] == "#")
                            newAgenda << [i, j+1]     
                        end
                        if(j-1 >= 0 && grid[i][j-1] == "#")
                            newAgenda << [i, j-1]     
                        end
                        grid[i][j] = "#{regionCount}"
                    end
                    agenda = newAgenda
                end
            end
        end
    end
    return regionCount
end

ARGF.each_line do |line|
    input = line.chomp
    puts mapInput(input, grid)
    puts tracePath(grid)
end


