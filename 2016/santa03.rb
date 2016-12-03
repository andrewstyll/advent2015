#! /usr/bin/env ruby

triangles = Array.new

def getValidTriangle(triangles)
    count = 0
    triangles.each do |t|
        a = t[0].to_i
        b = t[1].to_i
        c = t[2].to_i
        if((a+b>c) && (c+b>a) && (c+a>b))
            count += 1
        end
    end
    puts count
end

def getValidTriangle2(triangles)
    count = 0
        
    for i in 0...triangles[0].length do
        j = 0
        while j < triangles.length do
            a = triangles[j][i].to_i
            b = triangles[j+1][i].to_i
            c = triangles[j+2][i].to_i
            if((a+b>c) && (c+b>a) && (c+a>b))
                count += 1
            end
            j+=3
        end
    end
    puts count
end

ARGF.each_line do |line|
    input = line.chomp.split(' ')
    triangles.push(input)
end

getValidTriangle(triangles)
getValidTriangle2(triangles)
#f = File.open("input/santa03.txt", "w")
#
#triangleArray = Array.new
#
#ARGF.each_line do |line|
#    input = line.chomp.split(' ')
#    input.each do |n|
#        triangleArray.push(n)
#    end
#end
#
#i = 0
#while i < triangleArray.length do
#    f.write("#{triangleArray[i]} #{triangleArray[i+1]} #{triangleArray[i+2]}\n")
#    i +=3
#end
#f.close
