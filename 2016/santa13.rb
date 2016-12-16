#! /usr/bin/env ruby

class State
    attr_accessor :y, :x, :depth, :key
    def initialize(y, x, depth = 0)
        @y = y
        @x = x
        @depth = depth
        @key = makeKey
    end

    def makeKey
        string = ""
        string << @y.to_s
        string << @x.to_s
        return string
    end

    def solved
        if(@x == X && @y == Y)
            return true
        end
        return false
    end
end

class Move

    def self.isWall(y, x, num = FAVNUM)
        val = x*x + 3*x + 2*x*y + y + y*y + num
        count = 0
        while(val != 0)
            val = val & (val-1)
            count += 1
        end
        if(count%2 == 0)
            return false
        else
            return true
        end
    end

    def self.checkState(state, y, x, visited)
        if(!isWall(y, x))
            if(!visited.key?(state.key))
                visited[state.key] = state
                return true
            end
        end
        return false
    end

    def self.makeMoves(state, moves, visited)
        depth = state.depth
        #check up down left and right from my current spot
        newState = State.new(state.y-1, state.x, depth+1)
        if(checkState(newState, newState.y, newState.x, visited) && newState.y >= 0 )
            moves << newState
        end

        newState = State.new(state.y+1, state.x, depth+1)
        if(checkState(newState, newState.y, newState.x, visited))
            moves << newState
        end
        
        newState = State.new(state.y, state.x-1, depth+1)
        if(checkState(newState, newState.y, newState.x, visited) && newState.x >= 0)
            moves << newState
        end
        
        newState = State.new(state.y, state.x+1, depth+1)
        if(checkState(newState, newState.y, newState.x, visited))
            moves << newState
        end
        return moves
    end
end

def breadthFirst(newAgenda, searchAgenda, visited)
    solved = false
    while(true)
        searchAgenda.each do |move|
            Move.makeMoves(move, newAgenda, visited)
            if(move.solved)
                puts "found: #{move.depth}"
                solved = true
                #break
            end
        end
        if(newAgenda[0].depth == 49)
            puts "visited: #{visited.length-1}"
            break
        end
        if(solved)
            #break
        end
        searchAgenda = newAgenda[0...newAgenda.length]
        newAgenda = Array.new
    end
end

newAgenda = Array.new
searchAgenda = Array.new
visited = Hash.new

#FAVNUM = 10
#X = 7
#Y = 4

FAVNUM = 1364
X = 31
Y = 39

def part1(newAgenda, searchAgenda, visited)
    tmp = State.new(1, 1)
    searchAgenda << tmp
    visited[tmp.key] = tmp
    breadthFirst(newAgenda, searchAgenda, visited)
end

part1(newAgenda, searchAgenda, visited)
