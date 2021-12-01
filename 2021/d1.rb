file = File.open('2021/d1.txt')
depths = file_data = file.readlines.map(&:to_i)

## Part 1

higher = 0

depths.each_with_index do |depth, index|
  higher += 1 if (!depths[index + 1].nil? && depths[index] < depths[index + 1])
end
puts "Part 1: #{higher}"

## Part 2
higher = 0

depths.each_with_index do |depth, index|
  a = depths[index]
  b = depths[index + 1]
  c = depths[index + 2]

  next if (a.nil? || b.nil? || c.nil?)

  sum_a = a + b + c

  d = depths[index + 1]
  e = depths[index + 2]
  f = depths[index + 3]

  next if (d.nil? || e.nil? || f.nil?)

  sum_b = d + e + f

  sum_b > sum_a ? higher += 1 : higher += 0
end

puts "Part 2: #{higher}"
