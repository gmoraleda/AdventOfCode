require 'matrix'
require 'set'

file = File.open('2021/04/input')
lines = file_data = file.readlines.map(&:strip).map(&:to_str)

## Part 1

numbers = lines.first.split(',')
raw = lines[2..-1]

boards = []
board = []
j = 0
for i in 0..raw.length - 1
  if raw[i].empty?
    boards.push(Matrix[*board])
    board = []
    j = 0
    next
  end

  board[j] = raw[i].split(' ')
  j += 1
end

def check_column(column, array)
  mat = Matrix[*array]
  mat.column(column).to_a.all? { |x| x == 'x' }
end

def check_row(row, array)
  mat = Matrix[*array]
  mat.row(row).to_a.all? { |x| x == 'x' }
end

winner = nil
bingo = false
winning_number = nil

for n in numbers
  # Visiting the number
  for i in 0..boards.length - 1
    updated = boards[i].to_a.map { |row| row.map { |x| x == n ? 'x' : x } }
    boards[i] = Matrix[*updated]

    # Check columns
    for j in 0..boards[i].to_a.length - 1
      bingo = check_column(j, updated)
      break if bingo
    end

    if bingo == false
      # Check rows
      for j in 0..boards[i].to_a.length - 1
        bingo = check_row(j, updated)
        break if bingo
      end
    end

    if bingo
      winner = i
      break
    end
  end
  if bingo
    winning_number = n
    break
  end
end

sum = 0
boards[winner].to_a.map { |x| x.map { |y| sum += y.to_i if y != 'x' } }
puts 'Part 1:' + "#{sum * winning_number.to_i}"

# Part 2

boards = []
board = []
j = 0
for i in 0..raw.length - 1
  if raw[i].empty?
    boards.push(Matrix[*board])
    board = []
    j = 0
    next
  end

  board[j] = raw[i].split(' ')
  j += 1
end

winner = nil
last_won = false
winning_number = nil
boards_won = Set.new

for n in numbers
  # Visiting the number
  for i in 0..boards.length - 1
    updated = boards[i].to_a.map { |row| row.map { |x| x == n ? 'x' : x } }
    boards[i] = Matrix[*updated]

    # Check columns
    for j in 0..boards[i].to_a.length - 1
      bingo = check_column(j, updated)
      if bingo
        boards_won.add(i)
        if boards_won.length == boards.length
          last_won = true
          break
        end
      end
    end

    if last_won == false
      # Check rows
      for j in 0..boards[i].to_a.length - 1
        bingo = check_row(j, updated)
        if bingo
          boards_won.add(i)
          if boards_won.length == boards.length
            last_won = true
            break
          end
        end
      end
    end

    if last_won
      winner = i
      winning_number = n
      break
    end
  end
  break if last_won
end

sum = 0
boards[winner].to_a.map { |x| x.map { |y| sum += y.to_i if y != 'x' } }
puts 'Part 2:' + "#{sum * winning_number.to_i}"
