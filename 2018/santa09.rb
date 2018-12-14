#! /usr/bin/env ruby

inputs = []

# ruby is so stupid.... it doesn't have linked lists.....
class Node
    attr_accessor :val, :next, :prev
    def initialize(data, nextNode, prevNode)
        @val = data
        @next = nextNode
        @prev = prevNode
    end
end

class LinkedList
    attr_accessor :head, :tail, :size
    def initialize()
        @head = nil
        @tail = nil
        @size = 0
    end

    def createHead(val)
        @head = Node.new(val, nil, nil)
        @tail = @head
        @size += 1
        return @head
    end

    def insertAfterNode(val, node)
        newNode = Node.new(val, nil, nil)
        if(node == @tail)
            node.next = newNode
            newNode.prev = node
            @tail = newNode
        else
            tmp = node.next
            newNode.next = tmp
            newNode.prev = node
            tmp.prev = newNode
            node.next = newNode
        end
        @size += 1
        return newNode
    end


    # returns the next current node
    def removeNode(node)
        @size -= 1
        if(node == @head)
            @head = @head.next
            @head.prev = nil
            node.next = nil
            return @head
        elsif(node == @tail)
            @tail.prev = @tail
            @tail.next = nil
            node.prev = nil
            return @head
        else
            tmp1 = node.prev
            tmp2 = node.next
            node.next = nil
            node.prev = nil
            tmp1.next = tmp2
            tmp2.prev = tmp1
            return tmp2
        end
    end

    def iterateToIndex(node, current, new)
        tmp = node
        if(new > current)
            (current...new).each do |i|
                tmp = tmp.next
            end
        else
            (new...current).each do |i|
                tmp = tmp.prev
            end
        end
        return tmp
    end

    def printList()
        puts "============================="
        tmp = nil
        (0...@size).each do |i|
            if(i == 0)
                tmp = @head
            else
                tmp = tmp.next
            end
            print "#{tmp.val} -> "
        end
        puts "\n"
        puts "-----------------------------"
        tmp = nil
        (0...@size).each do |i|
            if(i == 0)
                tmp = @tail
            else
                tmp = tmp.prev
            end
            print "#{tmp.val} -> "
        end
        puts "\n"
        puts "============================="
    end
end

def playGame2(players, marbles)
    scores = {}
    game = LinkedList.new() 
    currentIndex = 0
    currentPlayer = 1
    currentNode = nil


    (0..marbles).each do |m|
        if(game.size == 0)
            currentNode = game.createHead(m)
        else
            if(m%23 != 0)
                insertIndex = currentIndex+1
                if(insertIndex == game.size)
                    insertIndex = 0
                    currentNode = game.head
                else
                    currentNode = game.iterateToIndex(currentNode, currentIndex, insertIndex)
                end
                currentNode = game.insertAfterNode(m, currentNode)
                
                currentIndex = insertIndex+1
                if(currentIndex == game.size)
                    currentIndex = 0
                end
            else
                if(currentIndex-7 < 0)
                    currentIndex = game.size+currentIndex-7
                    currentNode = game.iterateToIndex(game.tail, game.size, currentIndex)
                else
                    currentNode = game.iterateToIndex(currentNode, currentIndex, currentIndex-7)
                    currentIndex = currentIndex-7
                end
                if(!scores.include?(currentPlayer))
                    scores[currentPlayer] = m + currentNode.val
                else
                    scores[currentPlayer] += m + currentNode.val
                end
                currentNode = game.removeNode(currentNode)
            end
        end
        
        
        currentPlayer += 1
        if(currentPlayer == players+1)
            currentPlayer = 1
        end
    end

    maxVal = 0
    scores.each do |key, value|
        if(value > maxVal)
            maxVal = value
        end
    end
    return maxVal
end

def playGame1(players, marbles)
    scores = {}
    game = []
    currentIndex = 0
    currentPlayer = 1

    (0..marbles).each do |m|
        if(game.length == 0)
            game.push(m)
        else
            if(m%23 != 0)
                insertIndex = currentIndex+2
                if(insertIndex > game.length)
                    insertIndex = 1
                end
                if(insertIndex == game.length)
                    game.push(m)
                else
                    game.insert(insertIndex, m)
                end
                currentIndex = insertIndex
                if(currentIndex == game.length)
                    currentIndex = 0
                end
            else
                if(currentIndex-7 < 0)
                    currentIndex = game.length+currentIndex-7
                else
                    currentIndex = currentIndex-7
                end
                if(!scores.include?(currentPlayer))
                    scores[currentPlayer] = m + game[currentIndex]
                else
                    scores[currentPlayer] += m + game[currentIndex]
                end
                game.delete_at(currentIndex)
            end
        end
        currentPlayer += 1
        if(currentPlayer == players+1)
            currentPlayer = 1
        end
    end

    maxVal = 0
    scores.each do |key, value|
        if(value > maxVal)
            maxVal = value
        end
    end
    return maxVal
end

ARGF.each_line do |line|
    input = line.chomp.split
    numPlayers = input[0].to_i
    numMarbles = input[6].to_i
    inputs << [numPlayers,numMarbles]
end

inputs.each do |input|
    puts playGame2(input[0], input[1])
    puts playGame2(input[0], input[1]*100)
end
