#! /usr/bin/env ruby

TESTNUMROWS = 10
NUMROWS = 40
NUMROWS2 = 400000


def makeRow(input)
    newRow = Array.new()
    (0...input.length).each do |column|
        l = (column == 0 || input[column-1] == ".") ? false : true
        r = (column == input.length-1 || input[column+1] == ".") ? false : true
        
        if(l^r)
            newRow << "^"
        else
            newRow << "."
        end
    end
    return newRow
end

def countSafeTiles(input, numRows) 
    count = 0
    count += input.map{|row| row.count('.')}.inject(:+)
    (1...numRows).each do |row|
        input = makeRow(input) 
        count += input.map{|row| row.count('.')}.inject(:+)
    end
    return count
end

ARGF.each_line do |line|
    input = line.chomp.split(//)
    #puts countSafeTiles(input, TESTNUMROWS)
    #puts countSafeTiles(input, NUMROWS)
    puts countSafeTiles(input, NUMROWS2)
end
