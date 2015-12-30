#! /usr/bin/env ruby

string_code = 0
string_mem = 0
string_mem2 = 0

ARGF.each_line do |line|
    line = line.chomp
    string_code +=  line.length
    string_mem += (eval line).length
    string_mem2 += line.inspect.length
end

puts string_code - string_mem
puts string_mem2 - string_code
