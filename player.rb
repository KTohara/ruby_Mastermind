# frozen_string_literal: true

# Player super class for 'human/computer'
class Player
  MAX_TURNS = 12

  def initialize
    @previous_guesses = {}
  end

  protected

  attr_reader :code, :guess, :previous_guesses

  def compare(guess, code)
    guess_dup = guess.dup
    code_dup = code.dup
    [exact_match(guess_dup, code_dup), partial_match(guess_dup, code_dup)]
  end

  def exact_match(guess, code)
    (0...code.length).inject(0) do |count, i|
      next count unless code[i] == guess[i]

      code[i] = 'E'
      guess[i] = 'E'
      count + 1
    end
  end

  def partial_match(guess, code)
    (0...code.length).inject(0) do |count, i|
      next count unless code.include?(guess[i]) && guess[i] != 'E'

      partial_idx = code.index(guess[i])
      code[partial_idx] = 'P'
      guess[i] = 'P'
      count + 1
    end
  end

  def win?
    code == guess
  end

  def game_over
    puts win? ? game_message(:win) : game_message(:lose)
  end
end
