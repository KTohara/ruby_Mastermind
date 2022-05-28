require 'byebug'
require_relative 'display'

# Computer player class
class Computer
  include Display

  attr_reader :code, :guess, :possible_guesses, :previous_guesses, :first_guesses

  MAX_TURNS = 12
  PEGS = %w[1 2 3 4 5 6].freeze

  def initialize(code)
    @code = code
    @possible_guesses = PEGS.repeated_permutation(4).to_a # initialize now or later?
    @previous_guesses = {}
    @first_guesses = [%w[1 1 2 2], %w[3 3 4 4], %w[5 5 6 6]]
  end

  # def populate
  #   possible_guesses = Hash.new { |h, k| h[k] = [] }
  #   permutations = PEGS.repeated_permutation(4).to_a
  #   permutations.each_with_object(possible_guesses) { |perm, hash| hash[perm] }
  # end

  def play_turns
    (1..MAX_TURNS).each do |turn|
      puts "CODE: #{code.join(' ')}"
      puts "TURN: #{turn}"
      sleep(1)
      make_guess(turn, code)
      filter_guesses(possible_guesses)
      # show_guess(guess, self)
      # break if win?
    end
    game_over
  end

  def make_guess(turn, code)
    first_turns = (1..3).to_a
    if first_turns.include?(turn)
      @guess = first_guesses.sample
      first_guesses.delete(guess)
    else
      @guess = possible_guesses.sample
    end
    previous_guesses[guess] = compare_guess(guess, code)
  end

  def filter_guesses(possible_guesses, previous_guesses)
    last_guess = previous_guesses.keys.last
    last_hits = previous_guesses.values.last
    possible_guesses.each do |perm|
      possible_guesses.delete(perm) if last_guess.any? { |peg| perm.include?(peg) } && last_hits.length.zero?
      possible_guesses.delete(perm) if last_hits != compare_guess(perm, last_guess)
    end
    possible_guesses.length
  end

  # create all permutations of 1-6 hash: key: perm, val: [partial, exact]
  # first 3 guesses - 1122, 3344, 5566
  # check for partial
  # check for exact
  #
  # filter through permutations:
  #   * var lastguess, lastpartial, lastexact
  #   - iterate thru permutations (perm)
  #     - check each perm guess vs lastguess - insert partial and exact for each perm into all_guess_permutation
  #     - if perm partial + perm exact == 0
  #       - iterate thru last guess - delete all perms that include num in last guess
  #     - delete perm if perm partial != lastpartial and perm exact != lastexact

  def compare_guess(guess, code)
    peg_pairs = guess.zip(code)
    compare_pairs(peg_pairs)
  end

  def compare_pairs(peg_pairs)
    hits = ''
    wrong_guess = []
    wrong_code = []
    peg_pairs.each do |guess_peg, code_peg|
      hits << 'E' if guess_peg == code_peg
      wrong_guess << guess_peg
      wrong_code << code_peg
    end
    wrong_guess.each do |peg|
      if wrong_code.include?(peg)
        wrong_code.delete(peg)
        hits << 'P'
      end
    end
    hits
  end

  # def make_guess(total_hits)
  #   total_hits == 4 ? reorder_guess(total_hits) : iterate_guess(total_hits)
  # end

  # def iterate_guess(total_hits)
  #   next_guess = last_guess.take(total_hits)
  #   num = code.length - total_hits
  #   guess_num = last_guess[total_hits].to_i + 1
  #   num.times { next_guess << guess_num.to_s }
  #   next_guess
  # end

  # def reorder_guess(total_hits)
  #   last_guess
  # end

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
end

c = Computer.new(%w[2 2 1 1])
p c.make_guess(1, c.code)
p c.filter_guesses(c.possible_guesses, c.previous_guesses)
