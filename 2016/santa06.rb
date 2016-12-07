#! /usr/bin/env ruby

AREALLYBIGNUMBER = 1000

message = Array.new

def correctMessage(message)
    
    outstring = ""
    (0...message[0].length).each do |x|
        alphabet = Array.new(26, 0)
        (0...message.length).each do |y|
            alphabet[message[y][x].ord-97] += 1
        end
        index = alphabet.index(alphabet.max)
        outstring << (index+97).chr
    end
    puts outstring
end

def correctMessage2(message)
    
    outstring = ""
    (0...message[0].length).each do |x|
        alphabet = Array.new(26, 0)
        (0...message.length).each do |y|
            alphabet[message[y][x].ord-97] += 1
        end
        alphabet.map!{|i| (i == 0 ? AREALLYBIGNUMBER : i)}
        index = alphabet.index(alphabet.min)
        outstring << (index+97).chr
    end
    puts outstring
end

ARGF.each_line do |line|
    message.push(line.chomp.chars.to_a)
end

correctMessage(message)
correctMessage2(message)
