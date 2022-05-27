# frozen_string_literal: true

require_relative 'display'

# Computer player class
class Computer
  include Display

  attr_reader :code, :guess, :last_guess, :possible_guesses, :exact, :partial

  MAX_TURNS = 12

  def initialize(code)
    @code = code
    @guess = %w[1 1 1 1]
    @possible_guesses = []
  end

  def play_turns
    (1..MAX_TURNS).each do |turn|
      puts "CODE: #{code.join(' ')}"
      puts "TURN: #{turn}"
      sleep(1)
      total_hits = compare_guess
      make_guess(total_hits)
      show_guess(guess, self)
      break if win?
    end
    game_over
  end

  def compare_guess
    guess_dup = guess.dup
    code_dup = code.dup
    @exact = find_exact(guess_dup, code_dup)
    @partial = find_partials(guess_dup, code_dup)
    possible_guesses << guess if exact >= 1
    @last_guess = guess
    exact + partial
  end

  def make_guess(total_hits)
    total_hits == 4 ? reorder_guess(total_hits) : iterate_guess(total_hits)
  end

  def iterate_guess(total_hits)
    next_guess = last_guess.take(total_hits)
    num = code.length - total_hits
    guess_num = last_guess[total_hits].to_i + 1
    num.times { next_guess << guess_num.to_s }
    next_guess
  end

  def reorder_guess; end

  def find_exact(guess, code)
    (0...code.length).inject(0) do |count, i|
      next count unless code[i] == guess[i]

      code[i] = 'E'
      guess[i] = 'E'
      count + 1
    end
  end

  def find_partials(guess, code)
    (0...code.length).inject(0) do |count, i|
      next count unless code.include?(guess[i]) && guess[i] != 'E'

      partial_idx = code.index(guess[i])
      code[partial_idx] = 'P'
      guess[i] = 'P'
      count + 1
    end
  end
end
