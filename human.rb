# frozen_string_literal: true

# Human player class - holds most current stats to be placed into ::Board
class Human < Player

  def play_game
    until turn == 12
      board.render(stats)
      @guess = player_input
      @guess_hits = compare(guess, code)
      board.update_board(turn, guess, guess_hits, stats)
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
