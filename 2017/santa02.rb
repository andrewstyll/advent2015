#! /usr/bin/env ruby

total = 0

def getDiff(array)
    return (array.max - array.min)
end

def getDiv(array)
    ret = 0
    ar = array.combination(2).to_a
    ar.each do |comb|
        if( (comb.max%comb.min) == 0)
            ret = comb.max/comb.min
            return ret
        end
    end
    return ret
end

ARGF.each_line do |line|
    array = line.chomp.split.map{|n| n.to_i}
    #total += getDiff(array)
    total += getDiv(array)
end

puts total
