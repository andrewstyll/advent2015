#! /usr/bin/env ruby
require 'digest'

def getPwd(input)
    count = 0
    pwd = ""
    loop do 
        hash = Digest::MD5.hexdigest(input + count.to_s)
        if(hash[0...5] == "00000")
            puts hash[5]
            pwd << hash[5]
        end
        if pwd.length == 8
            break
        end
        count += 1
    end
    puts pwd
end

def getPwd2(input)
    count = 0
    
    pwd = Array.new(8)
    pwdSize = 0

    loop do 
        hash = Digest::MD5.hexdigest(input + count.to_s)
        if(Integer(hash[5]) rescue false)
            index = hash[5].to_i
            if(hash[0...5] == "00000" && index < 8 && pwd[index] == nil)
                puts hash[5..6]
                pwd[index] = hash[6]
                pwdSize += 1
            end
            if pwdSize == 8
                break
            end
        end
        count += 1
    end
    puts pwd.join(",")
end

ARGF.each_line do |line|
    input = line.chomp
    getPwd(input)
    getPwd2(input)
end
