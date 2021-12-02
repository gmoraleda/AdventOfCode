file = File.open('2021/02/input')
lines = file_data = file.readlines.map(&:to_str)

x = 0
y = 0

lines.each do |line|
  direction = line.split.first
  amount = line.split.last.to_i

  case direction
  when 'forward'
    x += amount
  when 'up'
    y += amount
  when 'down'
    y -= amount
  end
end

puts "Part 1: #{x.abs * y.abs}"

x = 0
y = 0
aim = 0

lines.each do |line|
  direction = line.split.first
  amount = line.split.last.to_i

  case direction
  when 'forward'
    x += amount
    y += (amount * aim)
  when 'up'
    aim += amount
  when 'down'
    aim -= amount
  end
end

puts "Part 2: #{x.abs * y.abs}"
