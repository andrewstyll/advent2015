#! /usr/bin/env ruby

pipes = Hash.new

STARTING_POINT = 0

def getGroupSize(pipes, start)
    groupSize = 1
    included = Hash.new
    toLookUp = []

    toLookUp << start
    included[start] = true

    while (toLookUp.length > 0)
        agenda = []
        toLookUp.each do |id|
            tmpAgenda = pipes[id.to_s]

            tmpAgenda.each do |tmpId|
                if(!included.has_key?(tmpId))
                    included[tmpId] = true
                    agenda << tmpId
                    groupSize += 1
                end
            end
        end
        toLookUp = agenda
        agenda = []
    end

    return groupSize
end

def getNumGroups(pipes)
    included = Hash.new
    # set up hash to determine if id has been seen before
    pipes.each do |key, value|
        included[key] = false
    end

    groupCount = 0

    pipes.each do |key, value|
        if(included[key] == false)
            
            groupCount+=1

            toLookUp = []
            toLookUp << key 
            included[key] = true

            while (toLookUp.length > 0)
                agenda = []
                toLookUp.each do |id|
                    tmpAgenda = pipes[id]
                    tmpAgenda.each do |tmpId|
                        if(included[tmpId.to_s] == false)
                            included[tmpId.to_s] = true
                            agenda << tmpId.to_s
                        end
                    end
                end
                toLookUp = agenda
                agenda = []
            end
        end
    end
    return groupCount
end

def fillPipes(pipes, input)
    input = input.chomp
    if match = input.match(/(\d+) <-> (.+)/)
        id, village = match.captures
        village = village.split(',').map{|n| n.to_i}
        pipes[id] = village
    end
end

ARGF.each_line do |line|
    fillPipes(pipes, line)
end

puts getGroupSize(pipes, STARTING_POINT)
puts getNumGroups(pipes)
