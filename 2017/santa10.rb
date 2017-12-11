#! /usr/bin/env ruby

# refers to the length of the hash array (NOT input)
#MAX_VALUE=5
MAX_VALUE=256

input = []
list = []

input2 = []
list2 = []
def hash(lengths, list, hash = nil)

    currentPos = 0
    skipSize = 0

    if(hash != nil)
        currentPos = hash[:currentPos]
        skipSize = hash[:skipSize]
    end

    # reverse order of #{length} elements in list starting at currentPos
    lengths.each do |l|
        i = currentPos
        j = currentPos+l-1
        numSteps = (l-1)/2
        
        if(j >= list.length)
            j = j%list.length
        end
        
        while(numSteps >= 0)
            if(i >= list.length) 
                i = 0
            end
            if(j < 0)
                j = list.length-1
            end

            tmp = list[i]
            list[i] = list[j]
            list[j] = tmp
            j-=1
            i+=1
            
            numSteps -= 1
        end
         
        currentPos += (l+skipSize)
        if(currentPos >= list.length)
            currentPos = currentPos%list.length
        end
        skipSize+=1
    end

    if(hash != nil)
        hash[:currentPos] = currentPos
        hash[:skipSize] = skipSize
    end
    return "#{list[0]*list[1]}"
end

def hash2(input, list)
    [17, 31, 73, 47, 23].each do |n|
        input << n
    end
   
    denseHash = []
    outString = ""

    tmpHash = Hash.new
    tmpHash[:currentPos] = 0
    tmpHash[:skipSize] = 0

    # list is what is being modified.
    64.times do
        hash(input, list, tmpHash)
    end
    # CORRECT ABOVE HERE

    list.each_slice(16) {|range|
        denseHash << range.inject{|xor, n| xor^n}
    }

    denseHash.each do |e|
        outString << sprintf("%02X", e)
    end

    return "#{outString}"
end

ARGF.each_line do |line|
    input = line.chomp.split(',').map{|n| n.to_i}
    input2 = line.chomp.split(//).map{|n| n.ord}
end

(0...MAX_VALUE).each do |n|
    list << n
    list2 << n
end

puts hash(input, list)
puts hash2(input2, list2)
