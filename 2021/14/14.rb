require 'pp'
require 'set'

file = File.open('14/input')
blocks = file.read.split("\n\n")

polymer = blocks.first
hash = {}

blocks
  .last
  .split("\n")
  .map do |line|
    values = line.split(' -> ')
    hash[values.first] = [
      "#{values.first[0]}#{values.last}",
      "#{values.last}#{values.first[1]}",
    ]
  end

appearances = {}

polymer.each_char do |char|
  if appearances[char]
    appearances[char] += 1
  else
    appearances[char] = 1
  end
end

words = Hash.new(0)
polymer
  .to_s
  .each_char
  .each_cons(2)
  .map { |s| s.join }
  .each { |s| words[s] += 1 }

for i in 0..39
  words_copy = words.clone
  words.each do |word, value|
    words_copy[word] -= value

    if words_copy.key?(hash[word][0])
      words_copy[hash[word][0]] += value
    else
      words_copy[hash[word][0]] = value
    end

    if words_copy.key?(hash[word][1])
      words_copy[hash[word][1]] += value
    else
      words_copy[hash[word][1]] = value
    end
  end

  words = words_copy
end

appearances = {}
words.each do |word, value|
  if appearances.key?(word[0])
    appearances[word[0]] += value
  else
    appearances[word[0]] = value
  end
end

appearances[polymer[-1]] += 1
pp appearances.sort_by { |key, value| value }

puts "Part 1: #{appearances.values.max - appearances.values.min}"
