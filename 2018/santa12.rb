#! /usr/bin/env ruby

NUM_GENERATIONS = 20
BIG_GEN = 50000000000
STATE_LEN = 5
PATTERN = "#.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.#...#.#"

rules = {}
baseState = ""

def getNextState(rules, stateArray)
    state = stateArray[0]
    firstPot = stateArray[1]
    outState = ""
    lastHash = 0

    (1...state.length+STATE_LEN).each do |c|
        min = [0, c-STATE_LEN].max
        max = [state.length, c].min
        checkRule = ""
        
        n = c-STATE_LEN
        while(n < 0) do
            checkRule << "."
            n += 1
        end
        
        checkRule << state[min...max]

        n = c-state.length
        while(n > 0) do
            checkRule << "."
            n -= 1
        end

        if(rules.include?(checkRule) && rules[checkRule] == "#")
            if(outState.length == 0)
                firstPot = firstPot - (c-3)
            end
            outState << "#"
            lastHash = outState.length
        else
            if(outState.length != 0)
                outState << "."
            end
        end
    end
    return [outState[0...lastHash], firstPot]
end

def getScore(state)
    score = 0
    (0...state[0].length).each do |pot|
        if(state[0][pot] == "#")
            score += pot-state[1]
        end
    end

    return score
end

def iterateState(rules, baseState)
    firstPot = 0

    # find index of first pot
    (0...baseState.length).each do |pot|
        if(baseState[pot] == "#")
            firstPot = pot
            break
        end
    end

    state = [baseState, firstPot]

    (0...NUM_GENERATIONS).each do |gen|
        state = getNextState(rules, state)
    end
    
    return getScore(state)
end

def getCrazyScore()
    firstPot = -1*(BIG_GEN-36)
    state = [PATTERN, firstPot]
    
    return getScore(state)
end

ARGF.each_line do |line|
    input = line.chomp.split
    if(input[0] == "initial")
        baseState = input[2]
    elsif(input.length > 1)
        rules[input[0]] = input[2]
    end
end

puts iterateState(rules, baseState)
puts getCrazyScore()
