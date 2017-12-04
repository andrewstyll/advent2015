#! /usr/bin/env ruby

input = Array.new()
input2 = Array.new()
def checkPass(inArr)
    total = 0
    inArr.each do |phrase|
        if(phrase.uniq.length == phrase.length)
            total += 1
        end
    end
    return total
end

ARGF.each_line do |line|
    array = line.chomp.split
    input << array

    array2 = Array.new()
    array.each do |e|
        array2 << e.clone
    end
    array2.each_with_index do |subPhrase, i|
        array2[i] = subPhrase.chars.sort.join
    end
    input2 << array2
end

puts checkPass(input)
puts checkPass(input2)
