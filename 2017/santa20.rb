#! /usr/bin/env ruby

BIG_NUMBER = 1000
#BIG_NUMBER = 3

particles = []
particles2 = []

class Vector
    attr_accessor :x, :y, :z
    def initialize(vector)
        @x = vector[0].to_i
        @y = vector[1].to_i
        @z = vector[2].to_i
    end

    def add(vector)
        @x += vector.x
        @y += vector.y
        @z += vector.z
    end

    def mDistance
        return @x.abs + @y.abs + @z.abs
    end
end

class Particle
    attr_accessor :destroyed, :p
    def initialize(p, v, a)
        @p = p
        @v = v
        @a = a
        @destroyed = false
    end

    def move(time)
        time.times do |i|
            @v.add(@a)
            @p.add(@v)
        end
    end
    
    def mDistance
        return @p.mDistance
    end

    def positionString
        # i'm so lazy....
        return "#{@p.x},#{@p.y},#{@p.z}"
    end

    def hasCollided
        return @destroyed
    end
end

def getDistance(particles)
    minDistance = nil
    minParticle = nil

    particles.each_with_index do |particle, i|
        particle.move(BIG_NUMBER)
        distance = particle.mDistance()
        if((minDistance == nil && minParticle == nil) || minDistance > distance)
            minDistance = distance
            minParticle = i
        end
    end
    return "#{minParticle}"
end

def countRemaining(particles)
    particleCount = particles.length
   
    BIG_NUMBER.times do |n|
        positions = Hash.new
        particles.each_with_index do |particle, i|
            if(!particle.destroyed)
                # check for collisions
                position = particle.positionString()
                if(!positions.has_key?(position))
                    # store position with index
                    positions[position] = i
                else
                    particle.destroyed = true
                    particleCount-= 1

                    otherParticle = particles[positions[position]]
                    if(!otherParticle.destroyed)
                        otherParticle.destroyed = true
                        particleCount-= 1
                    end
                end

                # update positions
                if(!particle.destroyed)
                    particle.move(1)
                end
            end
        end
    end

    return "#{particleCount}"
end

ARGF.each_line do |line|
    if(match = line.match(/p=<(\S+)>, v=<(\S+)>, a=<(\S+)>/))
        position, velocity, acceleration = match.captures
        p = Vector.new(position.split(','))
        v = Vector.new(velocity.split(','))
        a = Vector.new(acceleration.split(','))
        
        p2 = Vector.new(position.split(','))
        v2 = Vector.new(velocity.split(','))
        a2 = Vector.new(acceleration.split(','))

        particle = Particle.new(p, v, a)
        particle2 = Particle.new(p2, v2, a2)
        
        particles << particle
        particles2 << particle2
    end
end

puts getDistance(particles)
puts countRemaining(particles2) 
