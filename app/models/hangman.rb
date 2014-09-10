class Hangman < ActiveRecord::Base
  # Note: this could just as well come from a text file (read in an initializer) or
  #   from a Words table in the database
  WORD_LIST = %w( acres adult advice arrangement attempt August Autumn border breeze
    brick calm canal Casey cast chose claws coach constantly contrast cookies
    customs damage Danny deeply depth discussion doll donkey Egypt Ellen essential
    exchange exist explanation facing film finest fireplace floating folks fort
    garage grabbed grandmother habit happily Harry heading hunter Illinois image
    independent instant January kids label Lee lungs manufacturing Martin
    mathematics melted memory mill mission monkey Mount mysterious neighborhood
    Norway nuts occasionally official ourselves palace Pennsylvania Philadelphia
    plates poetry policeman positive possibly practical pride promised recall
    relationship remarkable require rhyme rocky rubbed rush sale satellites
    satisfied scared selection shake shaking shallow shout silly simplest slight
    slip slope soap solar species spin stiff swung tales thumb tobacco toy trap
    treated tune university vapor vessels wealth wolf zoo
  )

  belongs_to :user


  validates_presence_of :user, :answer, :max_misses, :misses

  def guessed_not_nil
    errors.add(:guessed, "cannot be nil") if guessed.nil?
  end
  validate :guessed_not_nil

  def available_letters
    ('a'..'z').to_a - guessed.split("")
  end

  def mask letter
    guessed.include?(letter) ? letter : "_"
  end

  def board
    answer.each_char.map { |char| mask(char) }.join
  end

  def guess(letter)
    letter.downcase!
    found = answer.include?(letter)

    unless guessed.include?(letter)
      self.guessed += letter
      self.misses  += 1 unless found
      save!
    end

    found
  end

  def finished?
    won? || lost?
  end

  def won?
    answer.each_char.all? { |char| guessed.include?(char) }
  end

  def lost?
    misses == max_misses
  end

  def state
    if won?
      "Won"
    elsif lost?
      "Lost"
    else
      "Playing"
    end
  end

  def percent_completed
    (misses.to_f / max_misses) * 100
  end

  def challenged_user
    self.challenged_id ? User.find(self.challenged_id) : nil
  end

  def solve_puzzle
    self.misses = self.max_misses
    self.save!
  end
  def hint
    self.answer.split("").sample()
  end
end
