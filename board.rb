# frozen_string_literal: true

require_relative 'display'

# Mastermind game state
class Board
  include Display

  attr_reader :code, :board

  def initialize(code)
    @code = code
    @board = Array.new(12) { { guess: Array.new(4, '_'), hits: Array.new(4, '_') } }
  end

  def guess_at(row)
    board[row][:guess]
  end

  def hits_at(row)
    board[row][:hits]
  end

  def update_guess(row, guess)
    board[row][:guess] = guess
  end

  def update_hits(row, hits)
    board[row][:hits] = hits
  end

  def previous_guesses
    board.reject do |row|
      row[:hits].all? { |el| el == '_' }
    end
  end

  def to_s
    peg_rows = board
               .map { |row| game_row(row[:guess], row[:hits]) }
               .join("\n#{divider_row}\n")

    "#{top_row}\n#{peg_rows}\n#{bottom_row}\n"
  end
end
