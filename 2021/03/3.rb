file = File.open('2021/03/input')
lines = file_data = file.readlines.map(&:strip).map(&:to_str)

## Part 1

zeros = Array.new(lines.first.length, 0)
ones = Array.new(lines.first.length, 0)

lines.each do |line|
  line
    .split('')
    .each_with_index do |char, index|
      if char == '0'
        zeros[index] += 1
      else
        ones[index] += 1
      end
    end
end

gamma = []
epsilon = []
for i in 0...zeros.length - 1
  gamma[i] = zeros[i] > ones[i] ? '0' : '1'
  epsilon[i] = zeros[i] < ones[i] ? '0' : '1'
end

puts "Part 1: #{gamma.join.to_i(2) * epsilon.join.to_i(2)}"

## Part 2

def get_most_common(array, result)
  return result += array.first if array.length == 1
  return result if array.length == 0
  zeros = 0
  ones = 0

  for i in 0...array.length
    array[i].split('').first == '0' ? zeros += 1 : ones += 1
  end

  array_next_iteration = []
  if zeros > ones
    array_next_iteration =
      array.filter { |x| x.split('').first == '0' }.map { |x| x[1..-1] }
    result += '0'
  else
    array_next_iteration =
      array.filter { |x| x.split('').first == '1' }.map { |x| x[1..-1] }
    result += '1'
  end

  return get_most_common(array_next_iteration, result)
end

def get_least_common(array, result)
  return result += array.first if array.length == 1
  return result if array.length == 0

  zeros = 0
  ones = 0

  for i in 0...array.length
    array[i].split('').first == '0' ? zeros += 1 : ones += 1
  end

  array_next_iteration = []
  if zeros < ones || zeros == ones
    array_next_iteration =
      array.filter { |x| x.split('').first == '0' }.map { |x| x[1..-1] }
    result += '0'
  else
    array_next_iteration =
      array.filter { |x| x.split('').first == '1' }.map { |x| x[1..-1] }
    result += '1'
  end

  return get_least_common(array_next_iteration, result)
end
result =
  get_most_common(lines, '').to_i(2) * get_least_common(lines, '').to_i(2)
puts "Part 2: #{result}"
