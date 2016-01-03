#! /usr/bin/env ruby

TOTAL_SECONDS = 2503

top_distance = 0

reindeer = Array.new()

def part1(input, top_distance)
    speed = input[3].to_i
    flying_time = input[6].to_i
    rest_time = input[13].to_i
    
    cycle = flying_time + rest_time
    distance_per_cycle = flying_time * speed
    remaining_time = (TOTAL_SECONDS % cycle)

    distance_travelled = ((TOTAL_SECONDS - remaining_time)/cycle) * speed * flying_time
    
    if remaining_time >= flying_time
        #add flying_time
        distance_travelled += speed * flying_time
    else
        #add remaining time times flying 
        distance_travelled += speed * remaining_time
    end
    
    if distance_travelled > top_distance
        top_distance = distance_travelled
    end

    return top_distance
end

def part2(reindeer_hash)
    
    TOTAL_SECONDS.times do
        top_distance = 0
        
        reindeer_hash.each do |reindeer|
            
            #update the distance 
            if reindeer[:mode] == "flying"
                reindeer[:distance] += reindeer[:speed]
            end

            if reindeer[:distance] >= top_distance
                top_distance = reindeer[:distance]
            end
            #update the status

            reindeer[:time_flown] -= 1

            if reindeer[:time_flown] <= reindeer[:rest_time]
                reindeer[:mode] = "resting"
            end

            if reindeer[:time_flown] == 0
                reindeer[:time_flown] = reindeer[:rest_time] + reindeer[:flying_time]
                reindeer[:mode] = "flying"
            end
        end
        reindeer_hash.select{ |reindeer| reindeer[:distance] == top_distance }.each do |reindeer| 
            reindeer[:score] += 1
        end
    end

    return reindeer_hash.map{ |x| x[:score]}.max

end

ARGF.each_line do |line|
    input = line.chomp.split(' ')

    reindeer << {
        speed: input[3].to_i,
        flying_time: input[6].to_i,
        rest_time: input[13].to_i,
        time_flown: input[6].to_i + input[13].to_i,
        mode: "flying",
        distance: 0,
        score: 0
    }
    top_distance = part1(input, top_distance)
end
puts top_distance
puts part2(reindeer) 
