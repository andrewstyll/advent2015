#! /usr/bin/env ruby

botList = Hash.new

PART1VALS = [17, 61]

class Bot
    #each bot needs a list of the chips it has recieved, a bot number, two places for it's chips to go

    def initialize(number)
        @number = number
        @chips = Array.new
    end

    def addChip(chip)
        @chips.push(chip)
        checkChips 
    end
    
    def makeRule(low, high)
        @passLow = low 
        @passHigh = high
        checkChips()
    end
    
    def checkChips
        if(@chips.length == 2)
            if(@chips.sort == PART1VALS)
                puts @number
            end
            giveChips()        
        end
    end

    def giveChips
        if(@passLow != nil && @passHigh != nil)
            low = @chips.min
            high = @chips.max
            @passLow.addChip(low)
            @passHigh.addChip(high)
        end
    end
end

def addRule(bot, low, high, botList)
    if(!botList.has_key?(low))
        botList[low] = Bot.new(low)
    end
    if(!botList.has_key?(high))
        botList[high] = Bot.new(high)
    end
    if(!botList.has_key?(bot))
        botList[bot] = Bot.new(bot)
    end
    botList[bot].makeRule(botList[low], botList[high])
end

def giveValue(value, bot, botList)
    if(!botList.has_key?(bot))
        botList[bot] = Bot.new(bot)
    end
    botList[bot].addChip(value.to_i)
end

ARGF.each_line do |line|
    if match = line.match(/(bot \d+) gives low to ((?:bot|output) \d+) and high to ((?:bot|output) \d+)/)
    #if match = line.match(/bot (\d+) gives low to bot (\d+) and high to bot (\d+)/)
        bot, low, high = match.captures
        #puts "bot: #{bot} low: #{low} high: #{high}"
        addRule(bot, low, high, botList)
    elsif match = line.match(/value (\d+) goes to (bot \d+)/)
        value, bot = match.captures
        giveValue(value, bot, botList)
    end
end

array = botList.values_at("output 0", "output 1", "output 2")
product = 1
array.each do |b|
    chipArray = b.instance_variable_get(:@chips)
    product *= chipArray.inject(:*)
end

puts product


