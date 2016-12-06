f = File.open("santa6.txt", "r")
lights_grid = Array.new(1000) {Array.new(1000) {0}}
op = ""
count = 0

f.each_line do |line|
    #parse input
    input = line.split(" ")
    if input.length == 5
        if input[1] == "on"
            op = "on"
        else
            op = "off"
        end

        min = input[2].split(',').map(&:to_i)
        x_min = min[0]
        y_min = min[1]

        max = input[4].split(',').map(&:to_i)
        x_max = max[0]
        y_max = max[1]
    else
        op = "toggle"

        min = input[1].split(',').map(&:to_i)
        x_min = min[0]
        y_min = min[1]

        max = input[3].split(',').map(&:to_i)
        x_max = max[0]
        y_max = max[1]
    end

    #control logic
    (x_min..x_max).each do |x|
        (y_min..y_max).each do |y|
            if op == "on"
                lights_grid[x][y] += 1
            elsif op == "off"
                if lights_grid[x][y] > 0
                lights_grid[x][y] -= 1
                end
            else
                lights_grid[x][y] += 2
            end
        end
    end
end
#thanks justin for this bit here
puts lights_grid.map { |row| row.inject(:+) }.inject(:+)
f.close

