f = File.open("santa5.txt", "r")
count_1 = 0
count_2 = 0
f.each_line do |line|
    line.strip!
    if line.match(/^((?!ab|cd|pq|xy).)*$/)
        if line.scan(/[aeiou]/).count >= 3
             if line.scan(/(\w)\1{1,}/).count >= 1
                count_1 += 1
            end
        end
    end

    if line.match(/(..).*\1/)
        if line.match(/(.).\1/)
            count_2 += 1
        end
    end 
end
puts count_1
puts count_2
f.close
