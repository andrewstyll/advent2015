#! /usr/bin/env ruby

containers = Array.new

def getCombos(containers)
    count = 0
    #now I have to do this for varying lengths.... we vary the length, as the combinations function creates combos of a
    #set length, and some combinations may use less bins than others.
    (containers.length).downto(0).each do |length|
        #use of combinations function prevents repetition in combinations. This allows me to do n choose k
        containers.combination(length).to_a.each do |combo| #generates combos
            if(combo.inject(:+) == 150)
                count += 1
            end
        end
    end
    puts count
end

def getCombos2(containers)
    count = 0
    #now I have to do this for varying lengths....
    0.upto(containers.length).each do |length| # start at 0 this time to come across the smallest combinations first
        containers.combination(length).to_a.each do |combo| #of that small combination, determine all the ways to order it
            if(combo.inject(:+) == 150) #check for 150 sums in the orders
                count += 1
            end
        end
        #for a min length we have now found the number of combination for that lengt :Dh
        if(count > 0)
            break
        end
    end
    puts count
end

ARGF.each_line do |line|
    containers.push(line.to_i)
end

getCombos(containers)
getCombos2(containers)
