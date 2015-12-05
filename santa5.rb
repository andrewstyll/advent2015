f = File.open("santa5.txt", "r")
count_1 = 0
count_2 = 0
f.each_line do |line|
    line.strip!
    if ["ab", "cd", "pq", "xy"].any? {|str| line.include?(str)} == false
        if line.scan(/[aeiou]/).count >= 3
             if line.scan(/(\w)\1{1,}/).count >= 1
                count_1 += 1
            end
        end
    end

    
end
puts count_1
puts count_2
f.close
