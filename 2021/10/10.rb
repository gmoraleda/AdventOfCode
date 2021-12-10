require 'pp'
file = File.open('10/input')
lines = file_data = file.readlines.map(&:strip).map(&:chars)

values = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }
corrupted = { ')' => 0, ']' => 0, '}' => 0, '>' => 0 }

stack = []
incomplete = []
for line in lines
  stack = []

  for char in line
    if char == '('
      stack << '('
    elsif char == ')'
      if stack.last == '('
        stack.pop
      else
        corrupted[')'] += 1
        stack = []

        break
      end
    elsif char == '['
      stack << '['
    elsif char == ']'
      if stack.last == '['
        stack.pop
      else
        corrupted[']'] += 1
        stack = []

        break
      end
    elsif char == '{'
      stack << '{'
    elsif char == '}'
      if stack.last == '{'
        stack.pop
      else
        corrupted['}'] += 1
        stack = []

        break
      end
    elsif char == '<'
      stack << '<'
    elsif char == '>'
      if stack.last == '<'
        stack.pop
      else
        corrupted['>'] += 1
        stack = []
        break
      end
    end
  end
  incomplete << stack.reverse if stack.any?
end
puts "Part 1: #{corrupted[')'] * values[')'] + corrupted[']'] * values[']'] + corrupted['}'] * values['}'] + corrupted['>'] * values['>']}"

scores = []
for line in incomplete
  score = 0

  for char in line
    value = 0

    if char == '('
      value = 1
    elsif char == '['
      value = 2
    elsif char == '{'
      value = 3
    elsif char == '<'
      value = 4
    end
    score = (5 * score) + value
  end
  scores << score
end

puts "Part 2: #{scores.sort[scores.length / 2]}"
