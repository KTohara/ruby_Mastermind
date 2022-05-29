# frozen_string_literal: true

# require_relative 'player'
require_relative 'human'
require_relative 'computer'
require_relative 'display'

# Input for starting game
class Mastermind
  include Display

  def run
    puts game_message(:greetings)
    input = gets.chomp
    until %w[1 2].include?(input)
      puts error(:game_mode)
      input = gets.chomp
    end
    code_breaker if input == '1'
    code_maker if input == '2'
    repeat_game
  end

  private

  def code_breaker
    breaker = Human.new
    breaker.play_turns
  end

  def code_maker
    code = input_new_code
    maker = Computer.new(code)
    maker.play_turns
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

  def repeat_game
    input = nil
    until %w[y n].include?(input)
      puts prompt(:replay)
      input = gets.chomp.downcase
      Mastermind.new.run if input == 'y'
    end
    puts game_message(:thanks)
    exit 0
  end
end

Mastermind.new.run if $PROGRAM_NAME == __FILE__
