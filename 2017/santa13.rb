#! /usr/bin/env ruby

firewall = Hash.new
firewall2 = Hash.new

def updateScanners(firewall)
    firewall.each do |layer, data|
        scanIndex = data[0]
        range = data[1]
        direction = data[2]

        if(range > 1)
            scanIndex+=direction

            if(scanIndex == range)
                direction*=-1
                scanIndex+=(2*direction)
            elsif(scanIndex == -1)
                direction*=-1
                scanIndex+=(2*direction)
            end
        end
        data[0] = scanIndex
        data[2] = direction
    end
end

def passPacket(firewall)
    severity = 0
    layerMax = firewall.keys.last.to_i
    0.upto(layerMax) do |i|
        # check if i'm caught
        if(firewall.has_key?(i.to_s))
            if(firewall[i.to_s][0] == 0)
                severity+=i*firewall[i.to_s][1]
            end
        end
        # update all scanners
        updateScanners(firewall)
    end
    return severity
end

def passPacket2(firewall)
    delay = -1
    while(true)
        delay+=1
        attemptPass = true
        firewall.each do |key, value|
            period = (value[1]*2)-2
             
            if( (delay+key.to_i)%period == 0)
                # then it's at 0 at this time
                attemptPass = false
                break
            end
        end
        if(attemptPass)
            break
        end
    end
    return delay
end

ARGF.each_line do |line|
    line.chomp!
    match = line.match(/(\d+): (\d+)/)
    depth, range = match.captures
    firewall[depth.to_s] = [0, range.to_i, 1] # current location of scanner, max scanner range, up or down
    firewall2[depth.to_s] = [0, range.to_i, 1] # current location of scanner, max scanner range, up or down
end

puts passPacket(firewall)
puts passPacket2(firewall2)
