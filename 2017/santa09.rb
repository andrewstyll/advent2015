#! /usr/bin/env ruby

def parseStream(stream)
    groupScore = 0
    garbageCount = 0
    inGarbage = false
    depth = 1

    i = 0
    while i < stream.length
        if(stream[i] == '!')
            i+=1
        elsif(stream[i] == '{' && inGarbage == false)
            groupScore += depth
            depth += 1
        elsif(stream[i] == '}' && inGarbage == false)
            depth -= 1
        elsif(stream[i] == '<' && inGarbage == false)
            inGarbage = true
        elsif(stream[i] == '>' && inGarbage)
            inGarbage = false
        elsif(inGarbage)
            garbageCount+=1
        end
        i+=1
    end
    return "groupScore: #{groupScore}, garbageCount: #{garbageCount}"
end

ARGF.each_line do |line|
    input = line.chomp.split(//)
    puts parseStream(input)
end

