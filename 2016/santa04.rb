#! /usr/bin/env ruby

rooms = Array.new

def cycleLetters(rooms)
    rooms.each do |room|
        data = room[0]
        cycle = room[1]
        for i in 0...data.length
            print (((data[i].ord-97+cycle)%26)+97).chr
        end
        puts " #{cycle}"
    end
end

def parseRooms(rooms)
    roomSum = 0
    validRooms = Array.new
    rooms.each do |room|
        alphabet = Array.new(26)
        alphabet.fill(0)
        data = room[0]
        roomNum = room[2].to_i
        checkSum = room[3][1..5]
        checkVal = ""

        for i in 0...data.length
            if data[i] == '-'
                next
            end
            alphabet[data[i].ord-97] += 1
        end
        for i in 0...5
            index = alphabet.index(alphabet.max)
            alphabet[index] = 0
            checkVal << (index+97).chr
        end
        if(checkVal == checkSum)
            roomSum += roomNum
            validRooms << [data, roomNum]
        end
    end
    puts roomSum
    cycleLetters(validRooms)
end

ARGF.each_line do |line|
    input = line.chomp.split(/([\W\-]+)([0-9]+)/)
    rooms.push(input)    
end

parseRooms(rooms)
