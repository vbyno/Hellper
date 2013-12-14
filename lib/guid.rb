module Guid
  CHARACTERS = ('A'..'Z').to_a
  DIGITS = ('0'..'9').to_a

  def self.random_triplet(array)
    3.times.reduce('') { |str| str + array.sample }
  end

  def self.generate_new
    [
      random_triplet(CHARACTERS),
      random_triplet(DIGITS),
      random_triplet(CHARACTERS),
      random_triplet(DIGITS),
      random_triplet(CHARACTERS)
    ].join('-')
  end
end