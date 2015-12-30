f = File.open("santa7.txt", "r")

#make a hash to store all of the calculations that have yet to have been completed
$tbd = Hash.new{ |hash, key| hash[key] = Proc.new{key.to_i} }

#make a hash to store all of the calculated values
$calculated = {}

#get calculated will take in an input signal. If the signal has a corresponding value, the value is returned, else
#if it doesn't exist in calculated, save that input signal as a 
def get_calculated(signal_i)
    if $calculated.has_key?(signal_i)
        return $calculated[signal_i]
    else
        $calculated[signal_i] = $tbd[signal_i].call
        return $calculated[signal_i]
    end
end

# a = b & c

f.each_line do |line|
    #parse inputs
    input = line.split(' ')
    if input.length == 3
        #it's an assignment
        $tbd[input[2]] = Proc.new{ |n| get_calculated(input[0]) }
    elsif input.length == 4
        #it's a NOT
        $tbd[input[3]] = Proc.new{ |n| ~get_calculated(input[1]) }
    elsif input.length == 5
        #it's a thingy
        if input[1] == 'AND'
            $tbd[input[4]] = Proc.new{ |n| get_calculated(input[0]) & get_calculated(input[2]) }
        elsif input[1] == 'OR'
            $tbd[input[4]] = Proc.new{ |n| get_calculated(input[0]) | get_calculated(input[2]) }
        elsif input[1] == 'LSHIFT'
            $tbd[input[4]] = Proc.new{ |n| get_calculated(input[0]) << input[2].to_i }
        elsif input[1] == 'RSHIFT'
            $tbd[input[4]] = Proc.new{ |n| get_calculated(input[0]) >> input[2].to_i }
        end 
    end
end

a = get_calculated("a")
$calculated = {}
$calculated['b'] = a

puts get_calculated("a")

f.close

#Proc saves a type of computation, and can have its values set outside of the function. In this test, we are setting our tbd hash value to be a computation with variable numbers.

#algorithm
#go through each line. If the required input values don't exist yet, store the computation in a hash. if it does exist, read from the computed hash
