input = []

def fuel_cost(fuel)
  ret = fuel/3-2
end

def calc_fuel(input)
  input.reduce(0) do |sum, el|
    sum += fuel_cost(el)
  end
end

def calc_fuel2(input)
  input.reduce(0) do |sum, el|
    total_cost = fuel_cost(el)
    remaining_cost = total_cost

    while(remaining_cost > 0) do
      remaining_cost = fuel_cost(remaining_cost)
      if(remaining_cost > 0)
        total_cost += remaining_cost
      end
    end
    sum += total_cost
  end
end

File.open(ARGV[0]).each do |line|
  input << line.to_i
end

puts calc_fuel2(input)
