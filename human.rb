# frozen_string_literal: true

# Human player class
class Human
  attr_reader :code, :turn, :guess, :exact, :partial

  def initialize
    @code = (1..4).inject([]) { |acc| acc << rand(1..6).to_s }
    @turn = 0
    # @code = %w[1 2 3 4]
    # @guess = %w[1 1 4 3]
  end

  def play_turns
    turn = 0
    until turn >= 12
      puts "CODE: #{code.join(' ')}"
      puts "TURN: #{turn}"
      @guess = player_input
      compare_guess
      turn += 1
      show_guess
      break if win?
    end
    game_over
  end

  def player_input
    puts "Make a guess - four digits between 1-6\n"
    input = gets.chomp
    until input.match?(/^[1-6]{4}$/)
      puts "Guess must be 4 digits between 1-6\n"
      input = gets.chomp
    end
    input.split('')
  end

  def compare_guess
    guess_dup = guess.dup
    code_dup = code.dup
    # puts "#{exact_match(guess_dup, code_dup)} exact"
    # puts "#{partial_match(guess_dup, code_dup)} partial"
    @exact = exact_match(guess_dup, code_dup)
    @partial = partial_match(guess_dup, code_dup)
    # p guess_dup
    # p code_dup
  end

  def exact_match(guess, code)
    count = 0
    (0...code.length).each do |i|
      next unless code[i] == guess[i]

      code[i] = 'E'
      guess[i] = 'E'
      count += 1
    end
    count
  end

  def partial_match(guess, code)
    # puts "#{guess} guess clone"
    # puts "#{code} code clone"
    count = 0
    (0...code.length).each do |i|
      next unless code.include?(guess[i]) && guess[i] != 'E'

      partial_match = code.index(guess[i])
      code[partial_match] = 'P'
      guess[i] = 'P'
      count += 1
    end
    count
  end

  def show_guess
    system('clear')
    puts
    puts "GUESS: #{guess.join(' ')}"
    puts "Exact: #{exact} | Partial: #{partial}"
    puts
  end

  def win?
    code == guess
  end

  def game_over
    if win?
      puts 'You win!'
    else
      puts 'You lose!'
    end
    repeat_game
  end

  def repeat_game
    input = nil
    until %w[y n].include?(input)
      puts 'Repeat game? (y)es/(n)o'
      input = gets.chomp.downcase
    end
    if input == 'y'
      Human.new.play_turns
    else
      puts 'Thanks for playing!'
      exit 0
    end
  end
end
