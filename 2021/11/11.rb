require 'pry'
require 'pp'
require 'set'

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

pp board
for i in 0..1
  hash.each { |key, value| hash[key] = value + 1 }

  hash_to_array(hash)

  octopus_to_flash = hash.select { |key, value| value > 9 }.keys.to_set
  flashed_neighbors = []

  for octopus in octopus_to_flash
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

    flashed_neighbors +=
      neighbors.map { |neighbor| "#{neighbor[0]}#{neighbor[1]}" }
  end

  flashed_neibors = flashed_neighbors.flatten! - octopus_to_flash.to_a

  flashed_neighbors.each { |neighbor| hash[neighbor] += 1 }

  # keys = hash.select { |key, value| value > 9 }.keys

  # log(keys)

  log(octopus_to_flash)
end

log(octopus_to_flash)

# while octopus_to_flash.length > 0
#   flashes += octopus_to_flash.length

#   octopus_to_flash.each do |key|
#     value = hash[key]
#     hash[key] = value % 10
#   end

#   flashed_neighbors = []
#   octopus_to_flash.each do |key|
#     flashed_neighbors.append(
#       neighbors.map { |neighbor| "#{neighbor[0]}#{neighbor[1]}" },
#     )

#     flashed_neighbors = flashed_neighbors.flatten! - octopus_to_flash
#   end
#   flashed_neighbors.each { |key| hash[key] += 1 }
#   octopus_to_flash =
# end
hash_to_array(hash)

# Flash neighbors

puts "Part 1: #{flashes}"
