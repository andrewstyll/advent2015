#! /usr/bin/env ruby

tower = Hash.new

class Program
    attr_accessor :weight, :parent, :children

    def initialize(weight, parent, children)
        @weight = weight
        @parent = parent
        @children = children
    end
end

def parseInput(program, weight, children, tower)
    if(!tower.has_key?(program)) # if key doesn't exist
        tower[program] = Program.new(weight, nil, nil)
    else
        tower[program].weight = weight
    end
    if(children != nil)
        tower[program].children = children
        children.each do |child|
            if(!tower.has_key?(child))
                tower[child] = Program.new(nil, program, nil)
            else
                tower[child].parent = program
            end
        end
    end
end

def findRoot(tower)
    tower.each do |program, value|
        if(tower[program].parent == nil)
            return program
        end
    end
end

def findWrongWeight(tower, root)
    children = tower[root].children
    childWeight = 0
    weightCheck = []

    if(children == nil)
        return tower[root].weight
    end
    
    firstWeight = nil
    conflictWeight = nil
    children.each do |child|
        weight = findWrongWeight(tower, child)
        
        if(firstWeight != nil && conflictWeight != nil)
            if(firstWeight[1] != weight)
                # first is wrong
                correction = tower[firstWeight[0]].weight + weight - firstWeight[1]
                puts "Correct Weight: #{correction}"
            else
                # conflict is wrong
                correction = tower[conflictWeight[0]].weight + weight - conflictWeight[1]
                puts "Correct Weight: #{correction}"
            end
            firstWeight = nil
            conflictWeight = nil

        elsif(firstWeight == nil)
            firstWeight = [child, weight]
        elsif(conflictWeight == nil && firstWeight[1] != weight) # there is a conflict in weights
            conflictWeight = [child, weight]
        end
        
        childWeight += weight
    end

    weightCheck.each do |child|
    end
    return childWeight + tower[root].weight
end

ARGF.each_line do |line|
    input = line.chomp
    if match = input.match(/(\w+) \((\w+)\) -> (.+)/)
        program, weight, children = match.captures
        children = children.split(', ')
        parseInput(program, weight.to_i, children, tower)
    elsif match = input.match(/(\w+) \((\w+)\)/)
        program, weight = match.captures
        parseInput(program, weight.to_i, nil, tower)
    end
end

root = findRoot(tower)
puts root
puts findWrongWeight(tower, root)
