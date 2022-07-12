# frozen_string_literal: true

# Computer player class - holds most current stats to be placed into ::Board
class Computer < Player

  attr_reader :correct_nums, :possible_guesses, :hit_count

  PEGS = %w[1 2 3 4 5 6].shuffle.freeze

  def initialize(code)
    super
    @correct_nums = nil
  end

  def play_game
    until turn == 12
      play_turn
      sleep(1)
      break if win?

      @turn += 1
    end
    game_over
  end

  def play_turn
    @guess = find_guess
    @guess_hits = compare(guess, code)
    @hit_count = find_hit_counts(guess_hits).sum
    @correct_nums = guess if hit_count == 4
    board.update_board(turn, guess, guess_hits, stats)
  end

  def find_guess
    correct_nums.nil? ? find_code_numbers : find_code_order(correct_nums)
  end

  def find_code_numbers
    return (1..4).map { |turn| PEGS[turn] } if turn.zero? || hit_count.zero?

    correct = guess.take(hit_count)
    correct << PEGS[turn] until correct.length == 4
    correct
  end

  def find_code_order(correct_nums)
    @possible_guesses = correct_nums.permutation.to_a.uniq
    possible_guesses.reject! { |perm| reject_guess?(perm) }
    possible_guesses.sample
  end

  def reject_guess?(perm_guess)
    board.previous_guesses.any? do |prev_guess|
      guess = prev_guess[:guess]
      guess_counts = find_hit_counts(prev_guess[:hits])
      perm_hits = compare(perm_guess, guess)
      perm_counts = find_hit_counts(perm_hits)
      guess_counts.first != perm_counts.first && guess_counts.last != perm_counts.last
    end
  end

  def find_hit_counts(hits)
    hits.each_with_object([0, 0]) do |type, acc|
      acc[0] += 1 if type == 'E'
      acc[1] += 1 if type == 'P'
    end
  end
end
