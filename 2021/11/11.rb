require 'pp'
file = File.open('11/test')
board =
  file
    .readlines
    .map(&:strip)
    .map(&:chars)
    .map { |line| line.map { |char| char.to_i } }

flashes = 0

def flash_neighbors(board, j, i)
  j_max = board[0].length - 1
  i_max = board.length - 1

  board[i + 1][j] += 1 if i + 1 <= i_max
  board[i - 1][j] += 1 if i - 1 >= 0
  board[i][j + 1] += 1 if j + 1 <= j_max
  board[i][j - 1] += 1 if j - 1 >= 0
  board[i + 1][j + 1] += 1 if i + 1 <= i_max && j + 1 <= j_max
  board[i - 1][j - 1] += 1 if i - 1 >= 0 && j - 1 >= 0
  board[i - 1][j + 1] += 1 if i - 1 >= 0 && j + 1 <= j_max
  board[i + 1][j - 1] += 1 if i + 1 <= i_max && j - 1 >= 0

  return board
end

def check_flash(board, j, i, flashes)
  j_max = board[0].length - 1
  i_max = board.length - 1

  return flashes if j > j_max || i > i_max || j < 0 || i < 0

  if board[i][j] > 9
    board[i][j] = 0

    flashed = flash_neighbors(board, j, i)
    pp flashed
    return(
      1 + check_flash(board, j + 1, i, 0) + check_flash(board, j - 1, i, 0) +
        check_flash(board, j, i + 1, 0) + check_flash(board, j, i - 1, 0) +
        check_flash(board, j + 1, i + 1, 0) +
        check_flash(board, j - 1, i - 1, 0) +
        check_flash(board, j - 1, i + 1, 0) +
        check_flash(board, j + 1, i - 1, 0)
    )
  else
    return flashes
  end
end

hash = {}

for i in 0..board.length - 1
  for j in 0..board[i].length - 1
    hash["#{i}#{j}"] = board[i][j]
  end
end

flashes = 0
for i in 0..3
  hash.each { |key, value| hash[key] = value + 1 }

  hash.each do |key, value|
    if value > 9
      hash[key] = 0
      flashes += 1
    end
  end

  while hash.values.max > 9
    hash.each do |key, value|
      if value > 9
      end
    end
  end
end

pp hash
