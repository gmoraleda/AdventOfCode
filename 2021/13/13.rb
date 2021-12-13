require 'pp'
require 'set'

file = File.open('13/input')
blocks = file.read.split("\n\n")

dots =
  blocks
    .first
    .split("\n")
    .map(&:strip)
    .map do |line|
      coordinates = line.split(',').map(&:to_i)
      [coordinates[0], coordinates[1]]
    end

instructions =
  blocks
    .last
    .split("\n")
    .map(&:strip)
    .map do |line|
      instruction = line.split(' ').last.split('=')
      [instruction[0], instruction[1].to_i]
    end

instruction = instructions.first
if instruction[0] == 'x'
  dots.map! do |dot|
    if dot[0] > instruction[1]
      distance = (dot[0] - instruction[1]).abs
      dot[0] = instruction[1] - distance
    end
    dot
  end
elsif instruction[0] == 'y'
  dots.map! do |dot|
    pp dot
    if dot[1] > instruction[1]
      distance = (dot[1] - instruction[1]).abs
      dot[1] = instruction[1] - distance
    end
    dot
  end
end

puts "Part 1: #{dots.to_set.length}"

instructions.drop(1)
for instruction in instructions
  if instruction[0] == 'x'
    dots.map! do |dot|
      if dot[0] > instruction[1]
        distance = (dot[0] - instruction[1]).abs
        dot[0] = instruction[1] - distance
      end
      dot
    end
  elsif instruction[0] == 'y'
    dots.map! do |dot|
      if dot[1] > instruction[1]
        distance = (dot[1] - instruction[1]).abs
        dot[1] = instruction[1] - distance
      end
      dot
    end
  end
end

dots.to_set

array = Array.new(dots.max[0] + 1) { Array.new(dots.max[1] + 1, ' ') }

dots.each { |dot| array[dot[0]][dot[1]] = '#' }

for i in 0..array.length - 1
  puts array[i].join('')
end

puts "Part 2: #{dots.to_set.length}"
