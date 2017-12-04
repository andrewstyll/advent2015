#! /usr/bin/env ruby

input = Array.new

#sort the inputs by the min values.
#The first break you come across should be where your min value exists

def findAvailableIp(ranges)
    ranges.sort!{|a, b| a[0].to_i <=> b[0].to_i}
end

def findRule(ranges)
    minIp = 0
    ranges.sort!{|a, b| a[0].to_i <=> b[0].to_i}
    ranges.each do |range|
        #check if Ip is in the range 
        if(minIp >= range[0].to_i && minIp <= range[1].to_i)
            minIp = range[1].to_i + 1 
        end
    end
    puts "minIP: #{minIp}"
end

ARGF.each_line do |line|
    input << line.chomp.split('-')
end

findRule(input)
findAvailableIp(input)
