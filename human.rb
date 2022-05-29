# frozen_string_literal: true

require_relative 'display'
require_relative 'player'

# Human player class
class Human < Player
  include Display

  def initialize
    super()
    @code = (1..4).inject([]) { |acc| acc << rand(1..6).to_s }
  end

  def play_turns
    (1..MAX_TURNS).each do |turn|
      puts "CODE: #{code.join(' ')}"
      puts "TURN: #{turn}"
      player_input
      previous_guesses[guess] = compare(guess, code)
      show_guess(guess, previous_guesses[guess])
      break if win?
    end
    game_over
  end

  protected

  def player_input
    puts prompt(:guess)
    input = gets.chomp
    until input.match?(/^[1-6]{4}$/)
      puts error(:code_error)
      input = gets.chomp
    end
    @guess = input.split('')
  end
end
