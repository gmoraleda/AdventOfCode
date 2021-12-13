require 'pp'
file = File.open('09/input')
board =
  file_data =
    file.readlines.map(&:strip).map(&:chars).map { |row| row.map(&:to_i) }

class Point
  attr_accessor :value
  attr_accessor :x
  attr_accessor :y
  attr_accessor :top
  attr_accessor :left
  attr_accessor :right
  attr_accessor :bottom
  def initialize(value, x, y, top, left, right, bottom)
    @value = value
    @x = x
    @y = y
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
        j,
        i,
        get_value(board, j, i - 1),
        get_value(board, j - 1, i),
        get_value(board, j + 1, i),
        get_value(board, j, i + 1),
      )
  end
end

lower_points = points.filter { |point| point.is_low_location }

puts 'Part 1: ' + lower_points.map { |point| point.value + 1 }.sum.to_s

# Part 2

visited = board.clone

def check(board, visited, x, y, marker)
  return if x < 0 || y < 0 || x >= board.first.size || y >= board.size
  return if board[y][x] == 9
  return if visited[y][x] == marker
  visited[y][x] = marker
  check(board, visited, x + 1, y, marker)
  check(board, visited, x - 1, y, marker)
  check(board, visited, x, y + 1, marker)
  check(board, visited, x, y - 1, marker)
end

lower_points.each_with_index do |point, index|
  visited[point.y][point.x] = -index

  check(board, visited, point.x + 1, point.y, -index)
  check(board, visited, point.x - 1, point.y, -index)
  check(board, visited, point.x, point.y + 1, -index)
  check(board, visited, point.x, point.y - 1, -index)
end

hash = {}
visited.each do |row|
  row
    .group_by(&:itself)
    .map do |k, v|
      if hash.has_key?(k)
        hash[k] += v.size
      else
        hash[k] = v.size
      end
    end
end

hash.delete(9)
puts "Part 2: #{hash.values.sort.reverse.slice(0, 3).reduce(:*)}"
