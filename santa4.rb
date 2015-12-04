require 'digest'

f = File.open("santa4.txt", "r")
f.each_line do |input|
    input.strip!
    count = 0
    loop do
        hash = Digest::MD5.hexdigest(input + count.to_s)
        if hash[0...6] == "000000"
            puts count.to_s
            break
        end
        if hash[0...5] == "00000"
            puts count.to_s
        end
        count += 1
    end
end
f.close
