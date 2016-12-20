#! /usr/bin/env ruby

data = Array.new

def inverse(a, m)
    t = 0
    newT = 1
    r = m
    newR = a

    while(newR != 0)
        quotient = r/newR
        oldT = t
        t = newT
        newT = oldT - quotient*newT
        oldR = r
        r = newR
        newR = oldR - quotient*newR
    end
    
    if t < 0
        return t+m
    end
    return t
end

def crt(data, product)
    time = 0

    data.each do |d|
        b = product/d[2]
        bPrime = inverse(b, d[2])
        time += (d[2] - (d[0] + d[1])%d[2])*b*bPrime #offset + time(increasing offset) mod size(since it's a disk) subtract from size(to see how far set back the disk is)
    end

    return time%product
end

product = 1

ARGF.each_line do |line|
    match = line.match(/Disc #(\d+) has (\d+) positions; at time=0, it is at position (\d+)./)
    offset, modulo, congruentTo = match.captures
    data << [congruentTo.to_i, offset.to_i, modulo.to_i]
    product *= modulo.to_i
end

puts crt(data, product)
