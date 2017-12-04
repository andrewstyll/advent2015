#! /usr/bin/env ruby

def findSeqSum(array)
    total = 0
    array.each_with_index do |n, i|
        if(i == array.length-1)
            if(n == array[0]) 
                total += n
            end
        else
            if(n == array[i+1])
                total += n
            end    
        end
    end
    return total
end

def findSeqSum2(array)
    total = 0
    len = array.length
    # array is always even length
    j = len/2 
    array.each_with_index do |n, i|
        newIndex = j+i
        if(newIndex >= len) 
            newIndex = j - ((len-1)-i) - 1
        end            
        if(n == array[newIndex])
            total += n
        end
    end
    return total
end

ARGF.each_line do |line|
    array = line.chomp.split(//).map{|chr| chr.to_i}
    #puts findSeqSum(array)
    puts findSeqSum2(array)
end
