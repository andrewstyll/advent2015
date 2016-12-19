#! /usr/bin/env ruby
require 'digest'

NUMHASHES = 64
INPUTSALT = "qzyelonm"
#INPUTSALT = "abc"

hashHash = Hash.new

def getHash(salt, hashHash)
    
    if(hashHash.key?(salt))
        return hashHash[salt]
    else
        string = Digest::MD5.hexdigest(salt)
        hashHash[salt] = string
        return string
    end
end

def findHashes(hashHash)
    n = 0 
    index = -1
    
    while(n < NUMHASHES)
        #make or get a hash of triples
        index += 1
        salt = INPUTSALT + index.to_s
        hash = getHash(salt, hashHash) 
        val = hash.match(/(.)\1\1/)
        if(val != nil)
            string = val[0][0]*5
            i = index
            (i+1..i+1000).each do |j|
                salt = INPUTSALT + j.to_s
                hash = getHash(salt, hashHash)
                if hash.match(string)
                    n += 1
                    break
                end
            end
        end
    end
    puts index
end

def getHash2(salt, hashHash)
    
    if(hashHash.key?(salt))
        return hashHash[salt]
    else
        stretchSalt = salt
        string = ""
        (0...2017).each do |n|
            string = Digest::MD5.hexdigest(stretchSalt)
            stretchSalt = string.downcase
        end
        hashHash[salt] = string
        return string
    end
end


def findHashes2(hashHash)
    n = 0 
    index = -1
    
    while(n < NUMHASHES)
        #make or get a hash of triples
        index += 1
        salt = INPUTSALT + index.to_s
        hash = getHash2(salt, hashHash)
        val = hash.match(/(.)\1\1/)
        if(val != nil)
            string = val[0][0]*5
            i = index
            (i+1..i+1000).each do |j|
                salt = INPUTSALT + j.to_s
                hash = getHash2(salt, hashHash)
                if hash.match(string)
                    n += 1
                    break
                end
            end
        end
    end
    puts index
end

findHashes(hashHash)
findHashes2(hashHash)
