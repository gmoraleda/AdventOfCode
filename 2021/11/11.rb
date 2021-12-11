require 'pry'
require 'pp'
require 'set'

def log(obj)
  Pry::ColorPrinter.pp(obj)
end

def hash_to_array(hash)
  board = Array.new(10) { Array.new(10) }
  hash.each do |key, value|
    i = key[0].to_i
    j = key[1].to_i
    board[i][j] = value
  end
  log(board)
end

file = File.open('11/input')
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

step = 0
while true
  step += 1
  hash.each { |key, value| hash[key] = value + 1 }
  total_flashing_octopus = hash.select { |key, value| value > 9 }.keys.to_set
  flashing_octopus = total_flashing_octopus

  while flashing_octopus.length > 0
    flashed_neighbors = []

    for octopus in flashing_octopus
      i = octopus[0].to_i
      j = octopus[1].to_i

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

    flashed_neighbors = flashed_neighbors.flatten! - total_flashing_octopus.to_a
    flashed_neighbors.each { |neighbor| hash[neighbor] += 1 }

    chained_flashing =
      hash.select { |key, value| value > 9 }.keys.to_set -
        total_flashing_octopus
    total_flashing_octopus = total_flashing_octopus + chained_flashing
    flashing_octopus = chained_flashing
  end

  total_flashing_octopus.each { |octopus| hash[octopus] = 0 }
  flashes += total_flashing_octopus.length
  break if total_flashing_octopus.length == hash.keys.length
end

puts "Part 1: #{flashes}"
puts "Part 2: #{step}"
