#! /usr/bin/env ruby

ipv7Addr = Array.new

ABBALENGTH = 4
ABALENGTH = 3

def checkABBA(string)
    (0...string.length-ABBALENGTH+1).each do |i|
        a = string[i]
        b = string[i+1]
        c = string[i+2]
        d = string[i+3]

        #puts "CHECK STRING: #{a} #{b} #{c} #{d}"

        if(a == d && b == c && a != b)
            return true
        end
    end
    return false
end

def checkIp(ipv7Addr)
    
    tlsCount = 0

    ipv7Addr.each do |ip|
        tlsValid = false
        (0...ip.length).each do |i|
            if ip[i].length < ABBALENGTH #no possible ABBA here
                next 
            end
            if(checkABBA(ip[i]))
                if i%2 == 0 #we want an ABBA here
                    tlsValid = true
                else #don't want ABBA here
                    tlsValid = false
                    break;
                end
            end
        end
        if(tlsValid == true)
            tlsCount += 1
        end
    end
    puts tlsCount
end

def checkIp2(ipv7Addr)
    
    sslCount = 0

    ipv7Addr.each do |ip|
        hyper = Array.new
        notHyper = Array.new
        (0...ip.length).each do |i|
            string = ip[i]
            if string.length < ABALENGTH #no possible ABBA here
                next 
            end
            
            (0...string.length-ABALENGTH+1).each do |n|
                a = string[n]
                b = string[n+1]
                c = string[n+2]
                if(a == c && a != b)
                    if(i%2 == 0)
                        notHyper.push(a+b)
                    else
                        hyper.push(b+a)
                    end
                end
            end 
        end
        if(notHyper.length > 0 && hyper.length > 0 && !(hyper & notHyper).empty?)
           sslCount += 1 
        end
    end
    puts sslCount
end

ARGF.each_line do |line|
    input = line.chomp.split(/[\[\]]/)
    ipv7Addr.push(input)
    #input = line.chomp.split(/\[([^\]]+)\]/)
    #puts "#{input}"
end

checkIp(ipv7Addr)
checkIp2(ipv7Addr)
