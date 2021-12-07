require 'pp'
require 'matrix'
file = File.open('2021/06/input')
fishes =
  file_data =
    file.readlines.map(&:strip).map { |line| line.split(',') }.first.map(&:to_i)

hash = [0, 1, 2, 3, 4, 5, 6, 7, 8].to_h { |x| [x, 0] }

for fish in fishes
  hash[fish] += 1
end

days = 256
for d in 0...days
  new_fishes = hash[0]
  hash[0] = hash[1]
  hash[1] = hash[2]
  hash[2] = hash[3]
  hash[3] = hash[4]
  hash[4] = hash[5]
  hash[5] = hash[6]
  hash[6] = hash[7] + new_fishes
  hash[7] = hash[8]
  hash[8] = new_fishes
end

puts "Part 1: #{hash.values.min}"
