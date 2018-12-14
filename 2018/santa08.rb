#! /usr/bin/env ruby

input = nil
$globalIt1 = 0
$globalIt2 = 0

def iterate1(input)

    sum = 0

    numChildren = input[$globalIt1]
    $globalIt1 += 1
    numData = input[$globalIt1]
    $globalIt1 += 1

    (numChildren).times do |n|
        sum += iterate1(input)
    end

    (numData).times do |n|
        sum += input[$globalIt1]
        $globalIt1 += 1
    end

    return sum
end

def iterate2(input)

    sum = 0

    numChildren = input[$globalIt2]
    $globalIt2 += 1
    numData = input[$globalIt2]
    $globalIt2 += 1

    childSums = {}

    (numChildren).times do |n|
        childSums[n+1] = iterate2(input)
    end


    (numData).times do |n|
        if(numChildren == 0)
            sum += input[$globalIt2]
        else
            if(childSums.include?(input[$globalIt2]))
                sum += childSums[input[$globalIt2]]
            else
                sum += 0
            end
        end
        $globalIt2 += 1
    end

    return sum
end

ARGF.each_line do |line|
    input = line.chomp.split.map {|n| n.to_i}
end

puts iterate1(input)
puts iterate2(input)
