#!/usr/bin/env ruby
require 'similis'

#Sample script showing how to do a simple option suggestion based on a list of valid options. 


valid_options = ['delete', 'list', 'add', 'test']

if ARGV.count == 0
  puts "Hello, this is a sample script, showing the capabilities of the Similis gem, please, add an extra option to the command
        line. Valid options are: #{valid_options.join(',')}"
  exit
end

param = ARGV[0]

if valid_options.include? param
  puts "Hey, you got one right! If you want to actually test the gem and what it can do, try misstyping one of the valid options."
else 
  Similis.preprocess({:options => valid_options}).with(:soundex)
  suggest = Similis.find_similar(param, :options)
  if suggest.nil?
    puts "Well, I have no idea what you're trying to do, you did not write anything that resembles one of the valid options, try again please!"
  else
    puts "Did you maybe try do write the option: #{suggest}?"    
  end
end
