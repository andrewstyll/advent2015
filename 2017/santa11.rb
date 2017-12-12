#! /usr/bin/env ruby
inputs = []

def getMinSteps(input)
    x = 0
    y = 0
    maxSteps = 0
    input.each do |dir|
        if(dir == 'n')
            y+=2
        elsif(dir == 's')
            y-=2
        elsif(dir == 'nw')
            y+=1
            x-=1
        elsif(dir == 'ne')
            y+=1
            x+=1
        elsif(dir == 'se')
            y-=1
            x+=1
        elsif(dir == 'sw')
            y-=1
            x-=1
        end
        currentMinSteps = x.abs + (y.abs-x.abs)/2
        if(currentMinSteps > maxSteps)
            maxSteps = currentMinSteps
        end
    end
    puts "maxSteps: #{maxSteps}"
    return "#{x.abs + (y.abs-x.abs)/2}"
end

ARGF.each_line do |line|
    inputs << line.chomp.split(',')
end

inputs.each do |input|
    puts getMinSteps(input)    
end
