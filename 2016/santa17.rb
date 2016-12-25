#! /usr/bin/env ruby
require 'digest'

TESTSALT = "ihgpwlah"
SALT = "qtetzkpl"

class State
    attr_accessor :y, :x, :passCode, :depth
    def initialize(y, x, passCode, depth = 0)
        @y = y
        @x = x
        @passCode = passCode
        @depth = depth
    end

    def solved
        if(x == 3 && y == 3)
            return true
        else
            return false
        end
    end
end

class Move
    def self.makeHash(passCode)
        return Digest::MD5.hexdigest(passCode)
    end

    def self.makeMoves(state, moves, salt)
        y = state.y
        x = state.x
        passCode = state.passCode
        depth = state.depth
        hash = makeHash(salt+passCode)
        
        newState = State.new(y-1, x, passCode+'U', depth+1)
        if(y-1 >= 0 && hash[0] > 'a')
            moves << newState
        end

        newState = State.new(y+1, x, passCode+'D', depth+1)
        if(y+1 < 4 && hash[1] > 'a')
            moves << newState
        end
        
        newState = State.new(y, x-1, passCode+'L', depth+1)
        if(x-1 >= 0 && hash[2] > 'a')
            moves << newState
        end
        newState = State.new(y, x+1, passCode+'R', depth+1)
        if(x+1 < 4 && hash[3] > 'a')
            moves << newState
        end
    end
end

def bFS(newAgenda, searchAgenda, salt)
    solved = false
    longestPath = 0

    while(true)
        searchAgenda.each do |move|
            if(move.solved)
                longestPath = longestPath > move.depth ? longestPath : move.depth
                #puts "found: #{move.passCode}"
                #solved = true
                #break
            else 
                Move.makeMoves( move, newAgenda, salt)
            end
        end
        if(solved || newAgenda.length == 0)
            puts "longest Path: #{longestPath}"
            break
        end
        searchAgenda = newAgenda[0...newAgenda.length]
        newAgenda = Array.new
    end
end

searchAgenda = Array.new
newAgenda = Array.new

def part1(newAgenda, searchAgenda)
    state = State.new(0, 0, '', 0) 
    searchAgenda << state
    bFS(newAgenda, searchAgenda, TESTSALT) 
    bFS(newAgenda, searchAgenda, SALT) 
end

part1(newAgenda, searchAgenda)
