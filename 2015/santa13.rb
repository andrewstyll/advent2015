#! /usr/bin/env ruby

happiness_hash = Hash.new{ |hash, key| hash[key] = Hash.new(0) }

def iterator(graph_i, current = nil, visited = [])

    remaining = graph_i.keys - visited - [nil]

    if remaining.empty?
        return graph_i[visited[0]][current]
    end

    vals = remaining.map do |person|
        graph_i[current][person] + iterator(graph_i, person, visited + [person])
    end
    return vals.max
end

ARGF.each_line do |line|
    input = line.chomp.split(' ')
    input[10] = input.last.split('.')[0]

    if input[2] == "lose"
        happiness_hash[input[0]][input[10]] += input[3].to_i * -1
        happiness_hash[input[10]][input[0]] += input[3].to_i * -1
    else
        happiness_hash[input[0]][input[10]] += input[3].to_i
        happiness_hash[input[10]][input[0]] += input[3].to_i
    end
    happiness_hash['Andrizzle'][input[0]] += 0
    happiness_hash[input[0]]['Andrizzle'] += 0
end
#puts happiness_hash
puts iterator(happiness_hash)
