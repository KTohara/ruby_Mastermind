# frozen_string_literal: true

require_relative 'board'

# Player super class for 'human/computer'
class Player
  def initialize(code, turn = 0)
    @code = code
    @board = Board.new(code)
    @turn = turn
  end

  private

  attr_reader :code, :guess, :guess_hits, :board, :turn

  def compare(guess, code)
    guess_dup = guess.dup
    code_dup = code.dup
    exact_match(guess_dup, code_dup)
    partial_match(guess_dup, code_dup)
    sort_hits(guess_dup)
  end

  def exact_match(guess, code)
    guess.each_index do |i|
      next unless guess[i] == code[i]

      code[i] = 'E' # exact match
      guess[i] = 'E'
    end
  end

  def partial_match(guess, code)
    guess.each_index do |i|
      next if guess[i] == 'E'

      if code.include?(guess[i])
        partial_idx = code.index(guess[i])
        code[partial_idx] = 'P' # partial match
        guess[i] = 'P'
      else
        guess[i] = 'M'
      end
    end
  end

  def sort_hits(hits)
    order = %w[E P M]
    hits.sort { |e1, e2| order.index(e1) <=> order.index(e2) }
  end

  def update_board
    board.update_guess(turn, guess)
    render_turn
    board.update_hits(turn, guess_hits)
    render
  end

  def stats
    "#{top_row}\n#{stats_row(turn + 1, code)}\n#{bottom_row}\n"
  end

  def render
    system('clear')
    puts banner
    puts stats
    puts board
  end

  def render_turn
    current_guess = board.guess_at(turn)
    empty_row = Array.new(4, '_')
    empty_row.each_index do |i|
      empty_row[i] = current_guess[i]
      board.update_guess(turn, empty_row)
      render
      sleep(0.5)
    end
  end

  def win?
    code == guess
  end

  def game_over
    render
    puts win? ? game_message(:win) : game_message(:lose)
  end
end
