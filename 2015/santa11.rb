#! /usr/bin/env ruby

def incrementor(string)
    string.next!  
end

ARGF.each_line do |line|
    input = line.chomp
    
    signal = ""
    loop do
        input = incrementor(input)
        for i in 0...(input.length-2)
            #get current value

            if (input.match(/^((?!i|o|l).)*$/) && input.match(/(.)*\1(.)*\2/))
                if input[i+1] == input[i].next && input[i+2] == input[i+1].next
                    if signal == "waiting"
                        signal = "second"
                    else
                        signal = "first"
                    end
                end
            end
        end
        if signal == "first"
            puts input
            signal = "waiting"
        elsif signal == "second"
            puts input
            break
        end
    end
end
