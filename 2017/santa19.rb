#! /usr/bin/env ruby

pipes = []

def findStart(pipes)
    pipes.each_with_index do |pipe, index|
        if(pipe == "|")
            return index
        end
    end
end

def followPipes(pipes)
    foundLetters = ""
    stepCount = 0
    
    direction = "D"
    i = 0
    j = findStart(pipes[0])

    iMax = pipes.length
    iMin = 0
    jMax = pipes[0].length
    jMin = 0

    while(i >= iMin && i < iMax && j >= jMin && j < jMax)
        if(pipes[i][j].match(/[a-zA-z]/))
            # if i have a letter, record it
            foundLetters << pipes[i][j]
        elsif(pipes[i][j] == "+")
            # if I have a plus sign, change direction
            if(direction != "U" && i+1 < iMax && (pipes[i+1][j] == "|" || pipes[i+1][j].match(/[a-zA-z]/)))
                direction = "D"    
            elsif(direction != "D" && i-1 >= iMin && (pipes[i-1][j] == "|" || pipes[i-1][j].match(/[a-zA-z]/)))
                direction = "U"
            elsif(direction != "R" && j-1 >= jMin && (pipes[i][j-1] == "-" || pipes[i][j-1].match(/[a-zA-z]/)))
                direction = "L"
            elsif(direction != "L" && j+1 < jMax && (pipes[i][j+1] == "-" || pipes[i][j+1].match(/[a-zA-z]/)))
                direction = "R"
            end
        elsif(pipes[i][j] == " ")
            break
        end
        
        # update coordinates
        if(direction == "D")
            i+=1
        elsif(direction == "U")
            i-=1
        elsif(direction == "L")
            j-=1
        elsif(direction == "R")
            j+=1
        end
        stepCount+=1
    end
    puts "#{stepCount}"
    return "#{foundLetters}"
end

ARGF.each_line do |line|
    pipes << line.chomp.split(//)
end

puts followPipes(pipes)
