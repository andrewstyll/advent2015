#! /usr/bin/env ruby

#SIDE_LENGTH = 8
SIDE_LENGTH = 1000

cloth = Array.new(SIDE_LENGTH) { Array.new(SIDE_LENGTH, 0) }
claims = Array.new()

def placeClaims(claims, cloth)
    ret = 0

    claims.each do |claim|
        height = claim[2]
        heightMax = claim[2] + claim[4]
        width = claim[1]
        widthMax = claim[1] + claim[3]
        
        (height...heightMax).each do |i|
            (width...widthMax).each do |j|
                cloth[i][j] += 1
            end
        end
    end

    (0...SIDE_LENGTH).each do |i|
        (0...SIDE_LENGTH).each do |j|
            if(cloth[i][j] >= 2)
                ret += 1
            end
        end
    end
    return ret
end

def findNoOverlap(claims, cloth)
    claims.each do |claim|
        height = claim[2]
        heightMax = claim[2] + claim[4]
        width = claim[1]
        widthMax = claim[1] + claim[3]
        
        noOverlap = true

        (height...heightMax).each do |i|
            (width...widthMax).each do |j|
                if(noOverlap && cloth[i][j] != 1)
                    noOverlap = false
                end
            end
        end
        if(noOverlap)
            return claim[0]
        end
    end
    return "no non-overlapping claim"
end

ARGF.each_line do |line|
    claim = Array.new(5)
    input = line.chomp.split(/[\sx:,#]/)
    claim[0] = input[1].to_i
    claim[1] = input[3].to_i
    claim[2] = input[4].to_i
    claim[3] = input[6].to_i
    claim[4] = input[7].to_i
    claims << claim
end

puts placeClaims(claims, cloth)
puts findNoOverlap(claims, cloth)
