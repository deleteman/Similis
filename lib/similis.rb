require './lib/processors/soundex_processor'
require './lib/processors/levenshtein_processor'

module Similis
  @@lists = Hash.new

  
  #Holds the list of words to be processed by algorithms like soundex
  class ToBeProcessedList
    @words = []
    @processed_words = []
    @method_used

    PROCESSORS = {:soundex => SoundexProcessor}

    def initialize list
      @words = list
      @processed_words = []
    end

    def get_processed_list
      @processed_words
    end

    def get_method
      @method_used
    end

    def with method
      @method_used = method
      @words.each do |w|
        value = PROCESSORS[method].calculate w
        @processed_words << {:word => w, :value => value}
      end
    end
  end

  def self.metaphone
  end

  def self.soundex string
    SoundexProcessor.calculate string
  end

  def self.needleman_wunsch
  end

  #Usage: Similis.preprocess({:key => list_of_words}).with(:algorithm)
  def self.preprocess my_hash
    k = my_hash.keys.first
    @@lists[k] = ToBeProcessedList.new(my_hash[k])
    @@lists[k]
  end


  #Calculates the Levenstein distance between two words
  def self.levenshtein(word, other, ins=2, del=1, sub=1)
    LevenshteinProcessor.calculate(word, other, ins, del, sub)
  end

  #The default method for finding a similar word, is by using Levenshtein distance
  def self.default_method word, list

    chosen_words = Hash.new

    best_distance = 999999

    list.each do |w|
      w["\n"] = ""
      w["\r"] = ""
      distance = levenshtein(word, w)
      if(distance <= best_distance)
        chosen_words[distance] = Array.new if chosen_words[distance].nil?
        chosen_words[distance] << w
        best_distance = distance
      end
    end
    #lets return the word if there is only one, or the list of words if there are more
    if chosen_words[best_distance].count == 1
      chosen_words[best_distance][0]
    else
      chosen_words[best_distance]
    end
  end

  def self.find_using_soundex word, list
    chosen_words = Hash.new
    soundex_key = soundex word
    list.each do |item|
      if item[:value] == soundex_key
        chosen_words[soundex_key] = Array.new if chosen_words[soundex_key].nil?
        chosen_words[soundex_key] << item[:word]
      end
    end
    if chosen_words[soundex_key].count == 1
      chosen_words[soundex_key][0]
    else 
      chosen_words[soundex_key]
    end
  end

  #Finds the most similar word to "word" from the list
  def self.find_similar(word, list) 
    method = nil

    if list.is_a? Symbol #If we're referencing the list, using a key for a preprocessed list...
      method = @@lists[list].get_method
      list = @@lists[list].get_processed_list
    end

    if !method.nil? and self.respond_to? method
      self.send("find_using_#{method}".to_sym, word, list)
    else
      default_method word, list
    end
  end

end