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

levels = Array.new
for level in 0..9
  level_board = Array.new(board.length) { Array.new(board.first.size) }

  for i in 0..(board.length - 1)
    for j in 0..(board.first.length - 1)
      if board[i][j] == level
        level_board[i][j] = board[i][j]
      else
        level_board[i][j] = nil
      end
    end
  end
  levels << level_board
end

def look_for_higher_level(levels, level, x, y, sum)
  return sum if level == 9

  max_y = levels[level].size - 1
  max_x = levels[level].first.size - 1

  current = levels[level]
  if y + 1 <= max_y && current[y + 1][x].nil? == false
    levels[level][y + 1][x] = nil
    return look_for_higher_level(levels, level + 1, x, y + 1, sum + 1)
  elsif x + 1 <= max_x && current[y][x + 1].nil? == false
    levels[level][y][x + 1] = nil
    return look_for_higher_level(levels, level + 1, x + 1, y, sum + 1)
  elsif y - 1 >= 0 && current[y - 1][x].nil? == false
    levels[level][y - 1][x] = nil
    return look_for_higher_level(levels, level + 1, x, y - 1, sum + 1)
  elsif x - 1 >= 0 && current[y][x - 1].nil? == false
    levels[level][y][x - 1] = nil
    return look_for_higher_level(levels, level + 1, x - 1, y, sum + 1)
  end
  return look_for_higher_level(levels, level + 1, x, y, sum)
end

basins = Array.new
for level in 0..8
  puts 'Level: ' + level.to_s
  for i in 0..(levels[level].length - 1)
    for j in 0..(levels[level].first.length - 1)
      if levels[level][i][j].nil? == false
        basin = look_for_higher_level(levels, level + 1, j, i, 1)
        basins << basin
      end
    end
  end
end
pp basins.sort.reverse.slice(0, 3)
