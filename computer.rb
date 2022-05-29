# frozen_string_literal: true

require_relative 'display'

# Computer player class
class Computer
  include Display

  attr_reader :code, :guess, :previous_guesses, :correct_nums, :possible_guesses

  MAX_TURNS = 12
  PEGS = %w[1 2 3 4 5 6].shuffle.freeze

  def initialize(code)
    @code = code
    @previous_guesses = {}
    @correct_nums = nil
  end

  def play_turns
    (1..MAX_TURNS).each do |turn|
      # show_code(code) # display board
      puts "turn message - diplay master code #{code}"
      puts "TURN #{turn}"
      @guess = correct_nums.nil? ? find_code_numbers(turn) : find_code_order(correct_nums, code)
      total_hits = compare(guess, code)
      @correct_nums = guess if total_hits.sum == 4
      previous_guesses[guess] = total_hits
      puts "GUESS: #{guess.join(' ')}"
      puts "HITS: #{previous_guesses[guess]}"
      game_over if win?
      puts
    end
  end

  def find_code_numbers(turn)
    return (1..4).inject([]) { |arr| arr << PEGS.first } if turn == 1
    total_hits = previous_guesses[guess].nil? ? 0 : compare(guess, code)
    correct = guess.take(total_hits.sum)
    correct << PEGS[turn - 1] until correct.length == 4
    correct
  end

  def find_code_order(correct_nums, code)
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
    puts win? ? game_outcome(:win) : game_outcome(:lose)
    repeat_game
  end

  def repeat_game
    input = nil
    until %w[y n].include?(input)
      puts prompt(:replay)
      input = gets.chomp.downcase
      play_turns if input == 'y'
    end
    puts game_outcome(:thanks)
    exit 0
  end
end