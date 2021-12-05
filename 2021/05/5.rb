require 'matrix'
require 'set'
require 'pp'

file = File.open('2021/05/input')
lines =
  file_data =
    file.readlines.map(&:strip).map(&:to_str).map { |line| line.split(' -> ') }

## Part 1

hash = {}
for line in lines
  vectors = line.map { |line| line.split(',') }

  # Vertical
  if vectors.first.first == vectors.last.first
    x = vectors.first.first.to_i
    y1 = [vectors.first.last.to_i, vectors.last.last.to_i].max
    y2 = [vectors.first.last.to_i, vectors.last.last.to_i].min

    while y1 >= y2
      if hash.has_key?([x, y2])
        hash[[x, y2]] += 1
      else
        hash[[x, y2]] = 1
      end
      y2 += 1
    end
  end

  # Horizontal
  if vectors.first.last == vectors.last.last
    x1 = [vectors.first.first.to_i, vectors.last.first.to_i].max
    x2 = [vectors.last.first.to_i, vectors.first.first.to_i].min
    y = vectors.last.last.to_i

    while x1 >= x2
      if hash.has_key?([x2, y])
        hash[[x2, y]] += 1
      else
        hash[[x2, y]] = 1
      end
      x2 += 1
    end
  end
end

sum = 0
hash.each_value { |v| sum += 1 if v >= 2 }
puts "Part 1: #{sum}"

# Part 2

def get_points(v1, v2)
  x1 = v1.first.to_i
  y1 = v1.last.to_i
  x2 = v2.first.to_i
  y2 = v2.last.to_i

  points = []

  # Vertical
  if x1 == x2
    y_1 = [y1, y2].min
    y_2 = [y1, y2].max
    while y_2 - y_1 >= 0
      points << [x1, y_1]
      y_1 += 1
    end
  elsif y1 == y2
    # Horizontal
    x_1 = [x1, x2].min
    x_2 = [x1, x2].max
    while x_2 - x_1 >= 0
      points << [x_1, y1]
      x_1 += 1
    end
  elsif x1 < x2 && y1 > y2
    # Upper right
    while x2 - x1 >= 0 && y1 - y2 >= 0
      points << [x1, y1]
      x1 += 1
      y1 -= 1
    end
  elsif x1 > x2 && y1 > y2
    # Upper left
    while x1 - x2 >= 0 && y1 - y2 >= 0
      points << [x1, y1]
      x1 -= 1
      y1 -= 1
    end
  elsif x1 > x2 && y1 < y2
    # Lower left
    while x1 - x2 >= 0 && y2 - y1 >= 0
      points << [x1, y1]
      x1 -= 1
      y1 += 1
    end
  else
    # Lower right
    while x2 - x1 >= 0 && y2 - y1 >= 0
      points << [x1, y1]
      x1 += 1
      y1 += 1
    end
  end

  return points
end

hash = {}
for line in lines
  vectors = line.map { |line| line.split(',') }
  points = get_points(vectors.first, vectors.last)
  points.each do |point|
    if hash.has_key?(point)
      hash[point] += 1
    else
      hash[point] = 1
    end
  end
end

sum = 0
hash.each_value { |v| sum += 1 if v >= 2 }
puts "Part 2: #{sum}"
