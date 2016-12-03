#! /usr/bin/env ruby

aunts = Array.new()

masterAunt = {
    children: 3,
    cats: 7,
    samoyeds: 2,
    pomeranians: 3,
    akitas: 0,
    vizslas: 0,
    goldfish: 5,
    trees: 3,
    cars: 2,
    perfumes: 1,
}

def compareAunts(aunts, masterAunt)
    aunts.each_with_index do |aunt, i|
        found1 = aunt.all? do |key, value|
            masterAunt[key.chomp(':').to_sym] == value.to_i
        end
        if found1
            puts "aunt1 == #{i+1}"
        end
    end
end

def compareAunts2(aunts, masterAunt)
    aunts.each_with_index do |aunt, i|
        found = aunt.all? do |key, value|
            newKey = key.chomp(':')
            if (newKey == 'trees' || newKey == 'cats')
                value.to_i > masterAunt[newKey.to_sym]
            elsif (newKey == 'goldfish' || newKey == 'pomeranians')
                value.to_i < masterAunt[newKey.to_sym]
            else
                masterAunt[newKey.to_sym] == value.to_i
            end
        end
        if found
            puts "aunt2 == #{i+1}"
        end
    end
end

#read in each value into an array 

ARGF.each_line do |line|
    array = line.chomp.split(' ')[2..-1]
    hash = Hash[*array.flatten]
    aunts.push(hash)
end

compareAunts(aunts, masterAunt)
compareAunts2(aunts, masterAunt)
