#! /usr/bin/env ruby
require 'json'

def counter(json, count)
    if json.class == Hash
        if json.values.include? ("red")
            return count
        else
            json.each { |key, value| count = counter(value, count) }
            return count
        end
    elsif json.class == Array
        json.each { |value| count = counter(value, count) }
        return count
    elsif json.class == Fixnum
        return (json.to_i + count)
    else
        return count
    end
end

parsed = JSON.parse(File.open(ARGV[0], "r").read())

puts counter(parsed, 0)
