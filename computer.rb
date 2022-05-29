# rubocop: disable Metrics/AbcSize
# frozen_string_literal: true

require_relative 'display'
require_relative 'player'

# Computer player class
class Computer < Player
  include Display

  attr_reader :correct_nums, :possible_guesses

  PEGS = %w[1 2 3 4 5 6].shuffle.freeze

  def initialize(code)
    super()
    @code = code
    @correct_nums = nil
  end

  def play_turns
    (1..MAX_TURNS).each do |turn|
      # show_code(code) # display board
      puts game_message(:show_code)
      puts "TURN #{turn}"
      @guess = correct_nums.nil? ? find_code_numbers(turn) : find_code_order(correct_nums)
      update_guesses
      puts "GUESS: #{guess.join(' ')}"
      puts "HITS: #{previous_guesses[guess]}"
      puts
      break if win?
    end
    game_over
  end

  def update_guesses
    total_hits = compare(guess, code)
    @correct_nums = guess if total_hits.sum == 4
    previous_guesses[guess] = total_hits
  end

  def find_code_numbers(turn)
    return (1..4).inject([]) { |arr| arr << PEGS.first } if turn == 1

    total_hits = previous_guesses[guess].nil? ? 0 : compare(guess, code)
    correct = guess.take(total_hits.sum)
    correct << PEGS[turn - 1] until correct.length == 4
    correct
  end

  def find_code_order(correct_nums)
    @possible_guesses = correct_nums.permutation.to_a.uniq
    possible_guesses.reject! { |perm| valid_guess?(perm, previous_guesses) }
    possible_guesses.sample
  end

  def valid_guess?(perm_guess, previous_guesses)
    previous_guesses.any? do |prev_guess|
      guess = prev_guess.first
      guess_hits = prev_guess.last
      perm_hits = compare(perm_guess, guess)
      guess_hits.first != perm_hits.first && guess_hits.last != perm_hits.last
    end
  end
end

# rubocop: enable Metrics/AbcSize
