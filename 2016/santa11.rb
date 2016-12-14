#! /usr/bin/env ruby

#I want to store my state as a hash? I think 
class State
    attr_accessor :depth, :chips, :generators, :elevatorFloor, :pairs, :key, :valid

    def initialize(elevatorFloor, generators, chips, depth = 0)
        @elevatorFloor = elevatorFloor #number of floor
        #put floor numbers in indexes
        @generators = generators #[P, C, Cu, R, Pl]
        @chips = chips #[P, C, Cu, R, Pl]
        @pairs = makePair
        @depth = depth #number of moves deep to get to this move
        @key = makeKey
        @valid = isValid
    end

    #get index chips on same floor as elevator
    def getChipsMatch
        @chips.each_index.select{|i| @chips[i] == @elevatorFloor}
    end
    
    def getGeneratorsMatch
        @generators.each_index.select{|i| @generators[i] == @elevatorFloor}
    end

    def getFloors
        if(@elevatorFloor == 3)
            return [@elevatorFloor-1]
        elsif(@elevatorFloor == 0)
            return[@elevatorFloor+1]
        else
            return[@elevatorFloor+1, @elevatorFloor-1]
        end
    end
    
    def makePair
        pair = []
        for i in 0...@generators.length do
            pair << [@generators[i], @chips[i]]
        end
        return pair
    end

    def makeKey
        key = ""
        key << @elevatorFloor.to_s
        key << @pairs.sort.flatten.join
        return  key
    end

    def isValid
        @chips.each_with_index do |chip, i|
            if(@generators.include?(chip) && @generators[i] != chip)
                return false
            end
        end
        return true
    end

    def solved
        if(@chips.min > 2 && @generators.min > 2)
            return true
        end
        return false
    end
end

class Moves
    # make a list of all available moves based on the current state
    # if i make moves (since i know the rules) I don't have to check move validity
    def self.checkState(state, visited)
        if(state.valid)
            if(!visited.key?(state.key))
                visited[state.key] = state
                return true
            end
        end
        return false
    end
    
    def self.makeMoves(state, moves, visited)
        
        chipsMatch = state.getChipsMatch
        gensMatch = state.getGeneratorsMatch
        floors = state.getFloors
        depth = state.depth
        
        #elevatorFloor, generators, chips, depth = 0

        #i can either move 1 generator/chip up or down
        floors.each do |floor|
            for i in 0...chipsMatch.length
                newChips = state.chips.dup
                newGens = state.generators.dup
                
                newChips[chipsMatch[i]] = floor
                newState = State.new(floor, newGens, newChips, depth+1)
                if(checkState(newState, visited))
                    moves << newState
                end
                #puts "#{newState.generators} #{newState.chips} #{newState.pairs} #{newState.valid}"
                #puts "#{moves}"
                
                #move 2 of the same
                for j in i+1...chipsMatch.length
                    newChips = state.chips.dup
                    
                    newChips[chipsMatch[i]] = floor
                    newChips[chipsMatch[j]] = floor
                    newState = State.new(floor, newGens, newChips, depth+1)
                    if(checkState(newState, visited))
                        moves << newState
                    end
                    #puts "#{newState.generators} #{newState.chips} #{newState.pairs} #{newState.valid}"
                end
            end
            
            for i in 0...gensMatch.length
                newChips = state.chips.dup
                newGens = state.generators.dup
                
                newGens[gensMatch[i]] = floor
                newState = State.new(floor, newGens, newChips, depth+1)
                if(checkState(newState, visited))
                    moves << newState
                end
                
                for j in i+1...gensMatch.length
                    newGens = state.generators.dup
                    
                    newGens[gensMatch[i]] = floor
                    newGens[gensMatch[j]] = floor
                    newState = State.new(floor, newGens, newChips, depth+1)
                    if(checkState(newState, visited))
                        moves << newState
                    end
                end
                #move a chip not that one
            end
            
            #move one of each
            for i in 0...gensMatch.length
                newGens = state.generators.dup
                
                newGens[gensMatch[i]] = floor
                
                for j in 0...chipsMatch.length
                    newChips = state.chips.dup
                    newChips[chipsMatch[j]] = floor
                    newState = State.new(floor, newGens, newChips, depth+1)
                    if(checkState(newState, visited))
                        moves << newState
                    end
                end
            end
        end
        return moves
    end
end

#(elevatorFloor, generators, chips, depth = 0)
#[P, C, Cu, R, Pl]
searchAgenda = Array.new
visited = Hash.new
newAgenda = Array.new

def breadthFirst(newAgenda, searchAgenda, visited)
    solved = false
    while(true)
        searchAgenda.each do |move|
            Moves.makeMoves(move, newAgenda, visited)
            if(move.solved)
                puts "found: #{move.depth}"
                solved = true
                break
            end
        end
        if solved
            break
        end
        searchAgenda = newAgenda[0...newAgenda.length]
        newAgenda = Array.new
    end
end

def test(newAgenda, searchAgenda, visited)
    start = Time.now
    tmp = State.new(0, [1, 2], [0,0])
    searchAgenda << tmp
    visited[tmp.key] = tmp
    breadthFirst(newAgenda, searchAgenda, visited)
    finish = Time.now
    puts "test time: #{finish-start}"
end

def part1(newAgenda, searchAgenda, visited)
    start = Time.now
    tmp = State.new(0, [0, 1, 1, 1, 1], [0, 2, 2, 2, 2])
    searchAgenda << tmp
    visited[tmp.key] = tmp
    breadthFirst(newAgenda, searchAgenda, visited)
    finish = Time.now
    puts "part1 time: #{finish-start}"
end

def part2(newAgenda, searchAgenda, visited)
    start = Time.now
    tmp = State.new(0, [0, 1, 1, 1, 1, 0, 0], [0, 2, 2, 2, 2, 0, 0])
    searchAgenda << tmp
    visited[tmp.key] = tmp
    breadthFirst(newAgenda, searchAgenda, visited)
    finish = Time.now
    puts "part2 time: #{finish-start}"
end

test(newAgenda, searchAgenda, visited)
part1(newAgenda, searchAgenda, visited)
part2(newAgenda, searchAgenda, visited)
