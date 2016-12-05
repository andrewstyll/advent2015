f = File.open("santa1.txt", "r")
current_floor = 0
position_count = 0
position_neg = 0
f.each_char do |c|
  position_count += 1
  if c == '('
    current_floor += 1
  elsif c == ')'
    current_floor -= 1
  end

  if current_floor == -1 && position_neg == 0
    position_neg = position_count 
  end
end
puts current_floor
puts position_neg
f.close
