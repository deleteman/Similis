class LevenshteinProcessor

  #Code taken from the net.. need to double check if it can be improved
  def self.calculate word, other, ins, del, sub
    return nil if word.nil? || other.nil?

    dm = []
    dm[0] = (0..word.length).collect { |i| i * ins}
    fill = [0] * (word.length - 1)

    for i in 1..other.length
      dm[i] = [i * del, fill.flatten] 
    end

    for i in 1..other.length
      for j in 1..word.length
        dm[i][j] = [
          dm[i-1][j-1] + (word[i-1] == other[i-1] ? 0 : sub),
          dm[i][j-1] + ins,
          dm[i-1][j] + del
          ].min
      end
    end

    dm[other.length][word.length]
  end
end

