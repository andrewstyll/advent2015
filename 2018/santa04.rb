#! /usr/bin/env ruby

logs = []
guards = {}

class Log
    attr_accessor :month, :day, :hour, :minute, :guard, :action
    def initialize(month, day, time, action)
        @month = month.to_i
        @day = day.to_i
        @hour = time.split(':')[0].to_i
        @minute = time.split(':')[1].to_i
        action = action.split
        if(action[0] == "Guard")
            @action = "guard"
            action[1][0] = ''
            @guard = action[1] 
        else
            @guard = nil
            if(action[0] == "falls")
                @action = "sleep"
            else
                @action = "wakes"
            end
        end
    end

    def <=>(log)
        if(@month < log.month)
            return -1
        elsif (@month > log.month)
            return 1
        else
            if(@day < log.day)
                return -1
            elsif(@day > log.day)
                return 1
            else
                if(@hour < log.hour)
                    return -1
                elsif(@hour > log.hour)
                    return 1
                else
                    if(@minute < log.minute)
                        return -1
                    else
                        return 1
                    end
                end
            end
        end
    end

end

def trackSleepy(logs, guards)
    
    currentGuard = nil
    sleepTime = 0

    logs.each do |log|
        if(log.action == "guard")
            currentGuard = log.guard
            sleepTime = 0
            if(!guards.has_key?(currentGuard))
                guards[currentGuard] = Array.new(60, 0)
            end
        elsif(currentGuard != nil && log.action == "sleep")
            sleepTime = log.minute
        elsif(currentGuard != nil && log.action == "wakes")
            array = guards[currentGuard]
            (sleepTime...log.minute).each do |i|
                array[i] += 1
            end
            guards[currentGuard] = array
        end
    end

end

def getSleepy(guards) 
    
    maxSlept = 0
    maxGuard = nil

    guards.each do |key, value|
        sum = 0
        value.each do |i|
            sum += i
        end
        if(sum > maxSlept)
            maxSlept = sum
            maxGuard = key
        end
    end

    maxSlept = 0
    array = guards[maxGuard]
    
    (0...array.length).each do |i|
        if(array[i] > array[maxSlept])
            maxSlept = i
        end
    end

    return maxSlept*maxGuard.to_i
end

def getSleepy2(guards)
    
    maxSlept = 0
    maxGuard = nil
    maxSleptMin = 0

    guards.each do |key, value|
        (0...value.length).each do |i|
            if(value[i] > maxSlept)
                maxSlept = value[i]
                maxSleptMin = i
                maxGuard = key
            end
        end
    end

    return maxSleptMin*maxGuard.to_i
end

ARGF.each_line do |line|
    action = ""
    month = ""
    day = ""
    time = ""

    input = line.chomp.split(']')
    action = input[1]
    input = input[0].split
    time = input[1]
    input = input[0].split('-')
    month = input[1]
    day = input[2]
    log = Log.new(month, day, time, action)
    logs << log
end

logs.sort! {|a, b| a <=> b }
trackSleepy(logs, guards)

puts getSleepy(guards)
puts getSleepy2(guards)
