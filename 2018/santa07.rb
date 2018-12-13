#! /usr/bin/env ruby

allLetters  = Hash.new()
NUM_WORKERS = 5

def removeLetterDep(allLetters, letter)

    allLetters.each do |key, value|
        if(value.include?(letter))
            value.delete(letter)
        end
    end
end

def processInstructions(allLetters)
    ret = ""
    toDo = []
    loop do
        # grab all elements with empty arrays
        allLetters.each do |key, value|
            if(value.length == 0)
                toDo << key
                allLetters.delete(key)
            end
        end
        toDo.sort!
        if(toDo.length != 0)
            removeLetterDep(allLetters, toDo[0])
            ret << toDo[0]
            toDo.delete(toDo[0])
        else
            break
        end
    end
    return ret
end

def processWorkers(allLetters)

    workers = []
    (0...NUM_WORKERS).each do |w|
        workers << Hash.new()
    end

    toDo = []

    i = -1
    loop do
        # decrement workers with jobs
        workers.each do |worker|
            if(worker.length != 0)
                worker.each do |key, value|
                    worker[key] -= 1
                    if(worker[key] == 0)
                        removeLetterDep(allLetters, key)
                        worker.delete(key)
                    end
                end
            end
        end

        allLetters.each do |key, value|
            # add to queue
            if(value.length == 0)
                toDo << key
                allLetters.delete(key)
            end
        end
        toDo.sort!
        
        if(toDo.length != 0)
            workers.each do |worker|
                if(worker.length == 0 && toDo.length != 0)
                    worker[toDo[0]] = toDo[0].ord - 'A'.ord + 1 + 60
                    toDo.delete(toDo[0])
                end
            end
        end

        i+=1
        
        endLoop = true
        workers.each do |worker|
            if(worker.length != 0)
                endLoop = false
            end
        end
        if(endLoop)
            break
        end
        
    end
    return i
end

ARGF.each_line do |line|
    input = line.chomp.split
    if(!allLetters.include?(input[1]))
        allLetters[input[1]] = []
    end
    if(!allLetters.include?(input[7]))
        allLetters[input[7]] = []
    end
    allLetters[input[7]] << input[1]
end

#puts processInstructions(allLetters)
puts processWorkers(allLetters)
