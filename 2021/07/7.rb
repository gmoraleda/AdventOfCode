require 'pp'
require 'matrix'
file = File.open('07/input')
crabs =
  file_data =
    file.readlines.map(&:strip).map { |line| line.split(',') }.first.map(&:to_i)

hash = {}

# Part 1

for destination in crabs
  if hash[destination] == nil
    for origin in crabs
      fuel = (destination - origin).abs
      if hash.has_key?(destination)
        hash[destination] += fuel
      else
        hash[destination] = fuel
      end
    end
  end
end

puts "Part 1: #{hash.values.min}"

# Part 2

def calc_fuel(x, y)
  # origin = [x, y].min
  # destination = [x, y].max
  # sum = 0
  # x = 1
  # for i in origin...destination
  #   sum += x
  #   x += 1
  # end
  # return sum

  n = (x - y).abs
  return n * (1 + n) / 2
end

hash = {}
starting = crabs.min
ending = crabs.max

for position in starting...ending
  for crab in crabs
    if hash.has_key?(position)
      hash[position] += calc_fuel(crab, position)
    else
      hash[position] = calc_fuel(crab, position)
    end
  end
end

puts "Part 2: #{hash.values.min}"
