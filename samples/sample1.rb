require 'rubygems'
require 'similis'

words = IO.readlines('brit-a-z.txt')

my_word = "catastrofe"

puts "Trying Levenshtein with a dictionary of #{words.count} words"
closest = Similis.find_similar(my_word, words)

puts "Your word: #{my_word}, did you mean #{closest.inspect}?"

puts "Now going for the soundex test..."
Similis.preprocess({:brit => words}).with(:soundex)
similar_sounding = Similis.find_similar(my_word, :brit)

puts "Your word sounds like: #{similar_sounding.inspect} "
