#! /usr/bin/env ruby

A_FACTOR = 16807
B_FACTOR = 48271
BIG_NUM = 2147483647
PAIR_COUNT = 40000000 # 40 million
PAIR_COUNT2 = 5000000 # 5 million

aStart = 0
bStart = 0

def getCount(a, b)
    count = 0

    0..PAIR_COUNT.times do |n|
        a = (a*A_FACTOR)%BIG_NUM
        b = (b*B_FACTOR)%BIG_NUM
        
        if (0xffff&a == 0xffff&b)
            count+=1
        end
    end
    return "#{count}"
end

def genAVal(a)
    loop do
        a = (a*A_FACTOR)%BIG_NUM
        if(a%4 == 0)
            return a
        end
    end
end

def genBVal(b)
    loop do
        b = (b*B_FACTOR)%BIG_NUM
        if(b%8 == 0)
            return b
        end
    end
end

def getCount2(a, b)
    count = 0

    0..PAIR_COUNT2.times do |n|
        a = genAVal(a)
        b = genBVal(b)
        if (0xffff&a == 0xffff&b)
            count+=1
        end
    end
    return "#{count}"
end

ARGF.each_line do |line|
    input = line.chomp.split(' ')
    if(aStart == 0)
        aStart = input[4].to_i
    else
        bStart = input[4].to_i
    end
end

puts getCount(aStart, bStart)
puts getCount2(aStart, bStart)
