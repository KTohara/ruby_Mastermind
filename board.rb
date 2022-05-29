# frozen_string_literal: true

require 'byebug'
require_relative 'display'
# Mastermind game state
class Board
  include Display

  attr_reader :code, :rows, :board

  def initialize(code, rows)
    @code = code
    @rows = rows
    @board = Array.new(12) { { guess: Array.new(4) {'empty'}, hits: Array.new(3) {0} } }
  end

  def guess_at(turn)
    board[turn - 1][:guess]
  end

  def hits_at(turn)
    board[turn - 1][:hits]
  end

  def update_guess(turn, guess)
    board[turn - 1][:guess] = guess
  end

  def update_hits(turn, hits)
    board[turn - 1][:hits] = hits
  end

  def to_s
    peg_rows = board.map do |row|
      # debugger
      game_row(row[:guess], row[:hits])
    end
    # debugger
    puts peg_rows
  end
end

b = Board.new('code', 12)
b.update_guess(1, %w[1 2 3 4])
b.update_hits(1, [1, 2, 1])
p b

puts b
