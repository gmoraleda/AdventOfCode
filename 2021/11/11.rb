require 'pry'
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

for i in 1..3
  hash.each { |key, value| hash[key] = value + 1 }

  while hash.values.any? { |value| value > 9 }
    Pry::ColorPrinter.pp hash

    hash.each do |key, value|
      if value > 9
        hash[key] = 0
        flashes += 1

        i = key[0].to_i
        j = key[1].to_i

        neighbors = [
          [i + 1, j],
          [i - 1, j],
          [i, j + 1],
          [i, j - 1],
          [i + 1, j + 1],
          [i - 1, j - 1],
          [i - 1, j + 1],
          [i + 1, j - 1],
        ]

        neighbors =
          neighbors.filter do |neighbor|
            neighbor[0] < board.length && neighbor[1] < board[0].length &&
              neighbor[0] >= 0 && neighbor[1] >= 0
          end

        neighbors.each { |neighbor| hash["#{neighbor[0]}#{neighbor[1]}"] += 1 }
      end
    end
  end
end

puts "Part 1: #{flashes}"
