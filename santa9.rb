#! /usr/bin/env ruby

#when an input is read in, store that input in a 2d array
map_hash = Hash.new{ |hash, key| hash[key] = Hash.new(0) }

def map(graph_i, current = nil, visited = [])
    #given some starting point, make a list of places you can go
    remaining = graph_i.keys - visited - [nil]
    if remaining.empty?
        return 0
    end
    #for each place you can go, see where you can go from that place
    vals = remaining.map do |location|
        #array + [location] stores a temp version of the array, so it is reverted once it is returned
        graph_i[current][location] + map(graph_i, location, visited + [location])
        #graph_i[current][location] + map(graph_i, location, visited + [location])
    end

    return vals.min
end

def map2(graph_i, current = nil, visited = [])
    #given some starting point, make a list of places you can go
    remaining = graph_i.keys - visited - [nil]
    if remaining.empty?
        return 0
    end
    #for each place you can go, see where you can go from that place
    vals = remaining.map do |location|
        #array + [location] stores a temp version of the array, so it is reverted once it is returned
        graph_i[current][location] + map2(graph_i, location, visited + [location])
        #graph_i[current][location] + map(graph_i, location, visited + [location])
    end

    return vals.max
end

ARGF.each_line do |line|
    input = line.split(' ')
    
    map_hash[input[0]][input[2]] = input[4].to_i
    map_hash[input[2]][input[0]] = input[4].to_i
end

puts map(map_hash)
puts map2(map_hash)
#start at some point, find the lowest cost trip. go to that place, and find the lowest cost trip and so on until all places are visited

#start at some point and calculate the cost of each possible trip.
#calculate the cost of every possible trip
