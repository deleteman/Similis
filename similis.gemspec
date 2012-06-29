#require './lib/conditionator.rb'
require 'date'

Gem::Specification.new do |s|
  s.name = "Similis"
  s.version = '0.1'#Conditionator::VERSION
  s.date = "#{Date.today.year}-#{'0' * ((Date.today.month < 10)?1:0)}#{Date.today.month}-#{Date.today.day}"
  s.summary = "Finds the similarities between words, using different algorithms"
  s.description = "This gem allows you to search for the closest word inside a list of specified known/valid words"
  s.authors = ["Fernando Doglio"]
  #s.files = ["lib/conditionator.rb", "lib/conditionator/hooks.rb"]
  s.email = "deleteman@gmail.com"
  #s.homepage = "https://github.com/deleteman/conditionator"
  s.required_ruby_version = '>= 1.9.2'
end