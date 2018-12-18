#! /usr/bin/env ruby

map = []
locations = {}

def isCart(c)
    return (c == 'v' || c == '^' || c == '<' || c == '>')
end

def goLeft(c)
    ret = ''
    if(c == '>')
        ret = '^'
    elsif(c == 'v')
        ret = '>'
    elsif(c == '<')
        ret = 'v'
    else
        ret = '<'
    end
    return ret
end

def goRight(c)
    ret = ''
    if(c == '>')
        ret = 'v'
    elsif(c == 'v')
        ret = '<'
    elsif(c == '<')
        ret = '^'
    else
        ret = '>'
    end
    return ret
end

def processCarts(map, locations)
    cartId = 0
    carts = []
    (0...map.length).each do |i|
        (0...map[i].length).each do |j|
            if(isCart(map[i][j]))
                carts << [cartId, i, j, map[i][j], 'L']  
                locations[i.to_s << "," << j.to_s] = cartId
                cartId += 1
            end
        end
    end
    return carts
end

def checkVisited(id, i, j, visited)
    key = i.to_s << "," << j.to_s
    val = id
    if(visited.include?(key))
        otherCart = visited[key]
        visited.delete(key)
        puts "Crash Between #{id} #{otherCart}"
        return otherCart
    else
        visited[key] = val
    end
    return -1
end

def addedToAgenda(id, i, j, direction, turn, agenda, visited, map)
    otherCart = checkVisited(id, i, j, visited)
    if(otherCart != -1)
        otherCart = agenda.find {|e| e[0] == otherCart}
        agenda.delete(otherCart)
        return false
    end
    
    if(map[i][j] == '-' || map[i][j] == '<' || map[i][j] == '>')
        newCart = [id, i, j, direction, turn]
        agenda << newCart
    elsif(map[i][j] == '|' || map[i][j] == 'v' || map[i][j] == '^')
        newCart = [id, i, j, direction, turn]
        agenda << newCart
    elsif(map[i][j] == '/')
        newCart = nil
        if(direction == '^')
            newCart = [id, i, j, '>', turn]
        elsif(direction == '<')
            newCart = [id, i, j, 'v', turn]
        elsif(direction == 'v')
            newCart = [id, i, j, '<', turn]
        elsif(direction == '>')
            newCart = [id, i, j, '^', turn]
        end 
        agenda << newCart
    elsif(map[i][j] == '\\')
        newCart = nil
        if(direction == '^')
            newCart = [id, i, j, '<', turn]
        elsif(direction == '<')
            newCart = [id, i, j, '^', turn]
        elsif(direction == 'v')
            newCart = [id, i, j, '>', turn]
        elsif(direction == '>')
            newCart = [id, i, j, 'v', turn]
        end 
        agenda << newCart
    elsif(map[i][j] == '+')
        newCart = nil
        if(turn == 'L')
            newCart = [id, i, j, goLeft(direction), 'S']
        elsif(turn == 'S')
            newCart = [id, i, j, direction, 'R']
        elsif(turn == 'R')
            newCart = [id, i, j, goRight(direction), 'L']
        end
        agenda << newCart
    end
    return true
end

def moveCarts(carts, map, locations)
    
    agenda = carts
    visited = locations

    firstCrash = false

    while(agenda.length != 0)
        
        newAgenda = []

        agenda.each do |cart|
            id = cart[0]
            i = cart[1]
            j = cart[2]
            direction = cart[3]
            turn = cart[4]
            
            key = i.to_s << "," << j.to_s
            if(visited.include?(key))
                visited.delete(i.to_s << "," << j.to_s)
                iNext = -1
                jNext = -1
                # determine next location for cart and if it will duplicate
                if(direction == 'v')
                    iNext = i+1
                    jNext = j
                elsif(direction == '^')
                    iNext = i-1
                    jNext = j
                elsif(direction == '<')
                    iNext = i
                    jNext = j-1
                else
                    iNext = i
                    jNext = j+1
                end

                if(!addedToAgenda(id, iNext, jNext, direction, turn, newAgenda, visited, map))
                    if(!firstCrash)
                        puts "firstCrash: #{jNext},#{iNext}"
                        firstCrash = true
                    end
                    puts "collision: #{visited.length}"
                end
            end
        end
        agenda = newAgenda.sort_by {|e| [e[1], e[2]]}
        if(agenda.length == 1)
            return "id: #{agenda[0][0]}: #{agenda[0][2]},#{agenda[0][1]}" 
        end
    end
end

ARGF.each_line do |line|
    map << line.chomp
end

carts = processCarts(map, locations)
puts moveCarts(carts, map, locations)
