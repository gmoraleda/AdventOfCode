require 'pry'
require 'pp'
file = File.open('11/test')
board =
  file
    .readlines
    .map(&:strip)
    .map(&:chars)
    .map { |line| line.map { |char| char.to_i } }

flashes = 0
hash = {}

for i in 0..board.length - 1
  for j in 0..board[i].length - 1
    hash["#{i}#{j}"] = board[i][j]
  end
end

for i in 0..2
  hash.each { |key, value| hash[key] = value + 1 }

  octopus_to_flash = hash.select { |key, value| value > 9 }.keys
  puts "octopus_to_flash: #{octopus_to_flash}"

  while octopus_to_flash.length > 0
    flashes += octopus_to_flash.length
    octopus_to_flash.each { |key| hash[key] = 0 }
    flashed_neighbors = []
    octopus_to_flash.each do |key|
      i = key[0].to_i
      j = key[1].to_i

      neighbors =
        [
          [i + 1, j],
          [i - 1, j],
          [i, j + 1],
          [i, j - 1],
          [i + 1, j + 1],
          [i - 1, j - 1],
          [i - 1, j + 1],
          [i + 1, j - 1],
        ].filter do |neighbor|
          neighbor[0] < board.length && neighbor[1] < board[0].length &&
            neighbor[0] >= 0 && neighbor[1] >= 0
        end

      flashed_neighbors.append(
        neighbors.map { |neighbor| "#{neighbor[0]}#{neighbor[1]}" },
      )
    end
    flashed_neighbors.flatten!.each { |key| hash[key] += 1 }
    octopus_to_flash = hash.select { |key, value| value > 9 }.keys
    puts "Octopus to flash: #{octopus_to_flash}"
  end

  # Flash neighbors
end

puts "Part 1: #{flashes}"
