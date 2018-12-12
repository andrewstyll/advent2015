#! /usr/bin/env ruby

poly = ""

UNITS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

def react(input)

    poly = input
    oldLen = -1
    
    while(poly.length != oldLen)
        oldLen = poly.length
        lastCopyIndex = 0
        newPoly = ""
        i = 0
        
        while(i < poly.length-1)
            if(poly[i] != poly[i+1] && (poly[i].downcase == poly[i+1] || poly[i].upcase == poly[i+1]))
                if(i > lastCopyIndex)
                    newPoly << poly[lastCopyIndex...i]
                end
                i+=2
                lastCopyIndex = i
            else
                i += 1
            end
        end
        if(lastCopyIndex < poly.length)
            if(i == poly.length)
                newPoly << poly[lastCopyIndex...i]
            elsif(i == poly.length-1)
                newPoly << poly[lastCopyIndex...i+1]
            end
        end
        if(newPoly != "")
            poly = newPoly
        end
    end
    return poly.length
end

def shortenPoly(input, units)
    minLen = input.length    
    
    units.each do |unit|
        poly = input
        poly = poly.gsub(unit, '')
        poly = poly.gsub(unit.upcase, '')
        newLen = react(poly)
        
        if(newLen < minLen)
            minLen = newLen
        end
    end
    return minLen
end

ARGF.each_line do |line|
    poly = line.chomp  
end

#puts react(poly)
puts shortenPoly(poly, UNITS)
