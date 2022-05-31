# frozen_string_literal: true

require_relative 'human'
require_relative 'computer'
require_relative 'display'
require_relative 'color'

# Input for starting game
class Mastermind
  include Display

  def run
    system('clear')
    puts game_message(:greetings)
    input = gets.chomp
    until %w[1 2].include?(input)
      puts error(:game_mode)
      input = gets.chomp
    end
    code_breaker if input == '1'
    code_maker if input == '2'
    repeat_game?
  end

  private

  def code_breaker
    code = (1..4).inject([]) { |acc| acc << rand(1..6).to_s }
    breaker = Human.new(code)
    breaker.play_game
  end

  def code_maker
    code = input_new_code
    maker = Computer.new(code)
    maker.play_game
  end

  def input_new_code
    puts prompt(:breaker_code)
    input = gets.chomp
    until input.match?(/^[1-6]{4}$/)
      puts error(:code_error)
      input = gets.chomp
    end
    input.split('')
  end

  def repeat_game?
    input = nil
    until %w[1 2].include?(input)
      puts prompt(:replay)
      input = gets.chomp.downcase
      Mastermind.new.run if input == '1'
    end
    puts game_message(:thanks)
    exit 0
  end
end

Mastermind.new.run if $PROGRAM_NAME == __FILE__
