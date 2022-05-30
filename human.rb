# frozen_string_literal: true

require_relative 'player'

# Human player class
class Human < Player
  include Display

  def play_game
    until turn == 11
      puts board
      @guess = player_input
      update_board
      break if win?

      turn += 1
    end
    game_over
  end

  def play_turn
    puts "CODE: #{code.join(' ')}"
    puts "TURN: #{turn}"
    player_input
    # previous_guesses[guess] = compare(guess, code)
    # show_guess(guess, previous_guesses[guess])
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
