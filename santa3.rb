f = File.open("santa3.txt", "r")
houses = Hash.new
norm_x = 0
norm_y = 0

robo_x = 0
robo_y = 0

turn_track = true

houses[[norm_x, norm_y]] = 1
f.each_char do |c|
  if turn_track == true
    if c == "^"
      norm_y += 1

    elsif c == "v"
      norm_y -= 1

    elsif c == "<"
      norm_x -= 1

    elsif c == ">"
      norm_x += 1
    end
    if houses.has_key?([norm_x, norm_y]) == false
      houses[[norm_x, norm_y]] = 1
    end
    turn_track = false
  else
    if c == "^"
      robo_y += 1

    elsif c == "v"
      robo_y -= 1

    elsif c == "<"
      robo_x -= 1

    elsif c == ">"
      robo_x += 1
    end
    if houses.has_key?([robo_x, robo_y]) == false
      houses[[robo_x, robo_y]] = 1
    end
    turn_track = true
  end
end
puts houses.length
f.close
