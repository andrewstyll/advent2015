#! /usr/bin/env ruby

def iterator(input)
    count = 0
    value = 0
    end_string = ""

    input = input.scan(/((\d)\2*)/).map(&:first)

    input.each do |x|
        count = x.length.to_s
        value = x.chars.first.to_s
        end_string << (count+value)
    end 
    return end_string
end

ARGF.each_line do |line|
    val = line
    for i in 0...50
        val = iterator(val)    
    end
    puts val.length
end
