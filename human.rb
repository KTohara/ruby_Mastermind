# frozen_string_literal: true

require_relative 'display'

# Human player class
class Human
  include Display

  MAX_TURNS = 12

  def initialize
    @code = (1..4).inject([]) { |acc| acc << rand(1..6).to_s }
    @previous_guesses = {}
  end

  def play_turns
    (1..MAX_TURNS).each do |turn|
      puts "CODE: #{code.join(' ')}"
      puts "TURN: #{turn}"
      player_input
      previous_guesses[guess] = compare(guess, code)
      show_guess(guess, previous_guesses[guess])
      game_over if win?
    end
  end

  protected

  attr_reader :code, :guess, :previous_guesses

  def player_input
    puts prompt(:guess)
    input = gets.chomp
    until input.match?(/^[1-6]{4}$/)
      puts error(:guess)
      input = gets.chomp
    end
    @guess = input.split('')
  end

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
    puts win?(code, guess) ? game_outcome(:win) : game_outcome(:lose)
    repeat_game
  end

  def repeat_game
    input = nil
    until %w[y n].include?(input)
      puts prompt(:replay)
      input = gets.chomp.downcase
      Human.new.play_turns if input == 'y'
    end
    puts game_outcome(:thanks)
    exit 0
  end
end
