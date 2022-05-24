class Human

  attr_reader :name, :code, :guesses
  
  def initialize(name)
    @name = name
    @code = Code.new()
    @guesses = []
  end

  def compare_guess

  end

  def win?

  end

  def repeat_game

  end

end