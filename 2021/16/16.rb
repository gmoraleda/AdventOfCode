require 'pp'
require 'set'

file = File.open('15/input')
board = file.read.split("\n").map { |line| line.split('').map(&:to_i) }

paths = Hash.new(0)

def move(x, y, board, path, paths)
  if x == board.first.size - 1 && y == board.size - 1
    paths[path] = path.split('').map(&:to_i).inject(:+)
    return
  end

  # Move right
  if x < board.first.size - 1
    move(x + 1, y, board, path + board[y][x + 1].to_s, paths)
  end

  # Move down
  if y < board.size - 1
    move(x, y + 1, board, path + board[y + 1][x].to_s, paths)
  end
end

move(0, 0, board, '', paths)

pp paths.values.min
