#! /usr/bin/env ruby

ingredients = Array.new
cals = Array.new
# score can only be calculated when the number of all ingredients are known
def getCookieVal(ingredients, portions, doCals, cals)
    
    sums = Array.new(ingredients[0].length, 0)

    ingredients.each_with_index do |ing, i|
        ing.each_with_index do |property, j|
            sums[j] += property*portions[i]
        end
    end
    
    if doCals == true
        tmpCals = 0
        portions.each_with_index do |portion, i|
            tmpCals += portion*cals[i] 
        end
        if tmpCals != 500
            return 0
        end
    end

    if(sums.any?{|val| val <= 0})
        return 0;
    end
    
    return sums.inject(:*)
end

# i need to find every possible way to break 100 into 5 different groups, then get the cookie values of each one
# this looks a bit like a tree...
def cookieScoring(portionsLeft, ingStored, ingredients, portions, doCals, cals)
    
    array = []
    
    if(ingStored == 3)
        return getCookieVal(ingredients, portions + [portionsLeft], doCals, cals)
    end

    for i in 0...portionsLeft
        array.push(cookieScoring(portionsLeft-i, ingStored+1, ingredients, portions+[i], doCals, cals))
    end
    return array.max
end

ARGF.each_line do |line|
    cookie = Array.new
    input = line.chomp.split(' ').map(&:to_i)
    ingredients.push([input[2], input[4], input[6], input[8]])
    cals.push(input[10])
end

puts cookieScoring(100, 0, ingredients, [], false, cals)
puts cookieScoring(100, 0, ingredients, [], true, cals)
