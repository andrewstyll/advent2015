#! /usr/bin/env ruby

rules = []
rulesMap = Hash.new

ITERATIONS = 18
start = ".#./..#/###"

def flip(rule)
    newRule = ""
    array = rule.split(/\//)
    # split up pixel
    array.each do |row|
        if(newRule != "")
            newRule << "/"
        end
        rowArray = row.strip.split(//)
        tmp = rowArray[0]
        rowArray[0] = rowArray[-1]
        rowArray[-1] = tmp
        newRule << rowArray.join
    end
    return newRule
end

def rotate(rule)
    newRule = ""
    array = rule.split(/\//)
    oldRules = []
    array.each do |row|
        rowArray = row.chomp.split(//)
        oldRules << rowArray
    end

    oldRules.each_with_index do |row, i|
        if(newRule != "")
            newRule << "/"
        end
        row.each_with_index do |col, j|
            newRule << oldRules[oldRules.length - j - 1][i]
        end
    end

    return newRule
end

def mapRules(rules, map)
    # rotate 4 times face up, 4 times face down
    rules.each do |rule|
        currentRule = rule[0]
        outRule = rule[1]
        record = false
        if(currentRule == "###/.../...")
            record = true
        else
            record = false
        end
        2.times do |m|
            4.times do |n|
                
                if(!map.has_key?(currentRule))
                    map[currentRule] = outRule
                end
                currentRule = rotate(currentRule)
            end
            currentRule = flip(currentRule)
        end
    end
end

def stringToArray(string)
    outArr = []
    array = string.split(/\//)
    array.each do |row|
        outArr << row.split(//)
    end
    return outArr
end

def getString(array, range, row, column)
    i = row
    iMax = i+range
    jMax = column+range
    findString = ""

    while(i < iMax)
        if(findString != "")
            findString << "/"
        end
        j = column
        while(j < jMax)
            findString << array[i][j]
            j+=1
        end
        i+=1
    end
    return findString
end

def countOn(start, map)
    inArr = stringToArray(start)
    ITERATIONS.times do |n|
        # convert input into 2D array
        range = 0
        if(inArr.length%2 == 0)
            range = 2
        elsif(inArr.length%3 == 0)
            range = 3
        else
            return "something has gone horribly wrong"
        end
        
        newArray = []
        newArrayIndex = 0
        i = 0
        while(i < inArr.length)
            j = 0

            while(j < inArr[0].length)
                findString = getString(inArr, range, i, j)
                foundString = map[findString]
                if(foundString == nil)
                    puts "#{findString}"
                    return "uh OH"
                end
                outString = stringToArray(foundString)
                # convert string to array and store/concat
                outString.each_with_index do |row, i|
                    if(newArray[newArrayIndex+i] == nil)
                        newArray[newArrayIndex+i] = row
                    else
                        newArray[newArrayIndex+i].push(*row)
                    end
                end
                j+=range
            end
            i+=range
            newArrayIndex+=range+1
        end
        inArr = newArray
    end
    onCount = 0
    inArr.each do |row|
        row.each do |col|
            if(col == "#")
                onCount+=1
            end
        end
    end
    return "#{onCount}"
end

ARGF.each_line do |line|
    rules << line.chomp.split(/ => /)
end

mapRules(rules, rulesMap)
puts countOn(start, rulesMap)
