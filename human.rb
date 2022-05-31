# frozen_string_literal: true

require_relative 'player'

# Human player class
class Human < Player
  include Display

  def play_game
    until turn == 12
      render
      @guess = player_input
      @guess_hits = compare(guess, code)
      update_board
      break if win?

      @turn += 1
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
