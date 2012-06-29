require './lib/similis'
require 'rubygems'

words = IO.readlines('brit-a-z.txt')

my_word = "incarserate"

closest = Similis.find_similar(my_word, words)

puts "Your word: #{my_word}, did you mean #{closest.inspect}?"

Similis.preprocess({:brit => words}).with(:soundex)
similar_sounding = Similis.find_similar(my_word, :brit)

puts "Your word sounds like: #{similar_sounding.inspect} "
