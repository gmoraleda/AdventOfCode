require 'pp'
file = File.open('08/input')
components =
  file_data = file.readlines.map(&:strip).map { |line| line.split(' | ') }

input = components.map { |component| component.first.split(' ') }
output = components.map { |component| component.last.split(' ') }

# Part 1
lengths = [2, 3, 4, 7]
sum = 0
output.each do |o|
  o.each { |code| sum += lengths.include?(code.length) ? 1 : 0 }
end

puts "Part 1: #{sum}"

# Part 2
def get_decoder(input)
  decoder = {}
  first_subset = []
  second_subset = []

  input.each do |code|
    if code.length == 2
      decoder[1] = code
    elsif code.length == 3
      decoder[7] = code
    elsif code.length == 4
      decoder[4] = code
    elsif code.length == 7
      decoder[8] = code
    elsif code.length == 5
      first_subset << code.split(//)
    elsif code.length == 6
      second_subset << code.split(//)
    end
  end

  four = decoder[4].split(//)

  for candidate in second_subset
    decoder[9] = candidate.join if (candidate - four).length == 2
  end
  remaining = second_subset.select { |code| code.join != decoder[9] }

  seven = decoder[7].split(//)
  for candidate in remaining
    if (candidate - seven).length == 3
      decoder[0] = candidate.join
    else
      decoder[6] = candidate.join
    end
  end

  one = decoder[1].split(//)
  for candidate in first_subset
    decoder[3] = candidate.join if (candidate - one).length == 3
  end
  remaining = first_subset.select { |code| code.join != decoder[3] }

  six = decoder[6].split(//)
  for candidate in remaining
    if (candidate - six).length == 0
      decoder[5] = candidate.join
    else
      decoder[2] = candidate.join
    end
  end

  dictionary = {}
  decoder.invert.each do |key, value|
    keys = key.split(//).permutation.map &:join
    keys.each { |k| dictionary[k] = value }
  end

  return dictionary
end

sum = 0
components.each do |component|
  input = component.first.split(' ')
  output = component.last.split(' ')

  dictionay = get_decoder(component.first.split(' '))
  sum += component.last.split(' ').map { |code| dictionay[code] }.join.to_i
end

puts "Part 2: #{sum}"
