require 'pp'
file = File.open('09/test')
board =
  file_data =
    file.readlines.map(&:strip).map(&:chars).map { |row| row.map(&:to_i) }

class Point
  attr_accessor :value
  attr_accessor :top
  attr_accessor :left
  attr_accessor :right
  attr_accessor :bottom
  def initialize(value, top, left, right, bottom)
    @value = value
    @top = top
    @left = left
    @right = right
    @bottom = bottom
  end

  def is_low_location
    return(
      [@top, @left, @right, @bottom].all? do |point|
        point.nil? ? true : point > @value
      end
    )
  end
end

def get_value(board, x, y)
  return nil if x < 0 || y < 0 || x >= board.first.size || y >= board.size
  board[y][x]
end

points = Array.new
for i in 0..(board.length - 1)
  for j in 0..(board[i].length - 1)
    points <<
      Point.new(
        get_value(board, j, i),
        get_value(board, j, i - 1),
        get_value(board, j - 1, i),
        get_value(board, j + 1, i),
        get_value(board, j, i + 1),
      )
  end
end

puts 'Part 1: ' +
       points
         .filter { |point| point.is_low_location }
         .map { |point| point.value + 1 }
         .sum
         .to_s

# Part 2

def check(board, x, y, sum)
  return sum if board[y][x] == 9

  max_y = board.length - 1
  max_x = board.first.length - 1

  return sum if (x < 0 || y < 0 || x >= max_x || y >= max_y)

  sum += 1

  return(
    check(board, x + 1, y, sum) + check(board, x - 1, y, sum) +
      check(board, x, y + 1, sum) + check(board, x, y - 1, sum)
  )
end

basins = Array.new

for i in 0..(board.length - 1)
  for j in 0..(board[i].length - 1)
    basin = check(board, j, i, 0)
    basins << basin
  end
end

pp basins
