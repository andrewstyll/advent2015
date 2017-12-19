#! /usr/bin/env ruby

pList = []
pList2 = []
instructions = []
map = Hash.new

#NUM_PROGRAMS = 5
#MAX_DANCE = 2

NUM_PROGRAMS = 16
MAX_DANCE = 1000000000

def rotate(array, n)
    n = n%array.length
    tmp = array[(array.length-n)..array.length]
    tmp2 = array[0..(array.length-1-n)]
    array = tmp + tmp2
    return array
end

def swapIndex(array, i, j)
    tmp = array[i]
    array[i] = array[j]
    array[j] = tmp
    return array
end

def swapValue(array, a, b)
    i = array.index(a)
    j = array.index(b)
    tmp = array[i]
    array[i] = array[j]
    array[j] = tmp
    return array
end

def getProgramOrder(pList, instructions)
    instructions.each do |i|
        if( match = i.match(/s(\d+)/) ) # rotate array by rotate
            n = match.captures.join.to_i
            pList = rotate(pList, n)
        elsif( match = i.match(/x(\d+)\/(\d+)/) ) # swap programs at index A, B
            pA, pB = match.captures
            pList = swapIndex(pList, pA.to_i, pB.to_i)
        elsif( match = i.match(/p(\w+)\/(\w+)/) ) # swap programs A, B
            pA, pB = match.captures
            pList = swapValue(pList, pA, pB)
        end
    end
    return pList
end

def getProgramOrder2(pList, instructions, map)
    MAX_DANCE.times do |n|
        if(!map.has_key?(pList.join))
            map[pList.join] = n
        else
            lookUp = MAX_DANCE%n
            return "#{map.key(lookUp)}"
        end
        pList = getProgramOrder(pList, instructions)
        
    end
    return pList.join
end


ARGF.each_line do |line|
    instructions = line.chomp.split(',')
end

97.upto(97+NUM_PROGRAMS-1) do |n|
    pList << n.chr
    pList2 << n.chr
end

puts getProgramOrder(pList, instructions).join
puts getProgramOrder2(pList2, instructions, map)
