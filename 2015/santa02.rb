f = File.open("santa2.txt", "r")
sq_feet = 0
bow_feet = 0
f.each_line do |line|
  sides = Array.new(3)
  val = line.split("x").map(&:to_i)
  
  sides[0] = val[0]*val[1]
  sides[1] = val[1]*val[2]
  sides[2] = val[2]*val[0]

  sq_feet += 2*(sides[0] + sides[1] + sides[2]) + sides.min 
  val = val.sort
  bow_feet += (2*(val[0] + val[1]) + val.inject(:*))
end
puts sq_feet
puts bow_feet
f.close
