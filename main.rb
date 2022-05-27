# frozen_string_literal: true

require_relative 'human'
require_relative 'computer'

# Input for starting game
class Game
  def self.run
    puts "Let's play Mastermind!"
    puts 'Press (1) to be a code BREAKER'
    puts 'Press (2) to be a code MAKER'
    input = gets.chomp
    until %w[1 2].include?(input)
      puts 'Enter (1) to be a code BREAKER, (2) to be a code MAKER'
      input = gets.chomp
    end
    code_breaker if input == '1'
    code_maker if input == '2'
  end

  class << self
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
      puts "Enter a 4 digit 'code' using numbers 1-6 for each digit, to be broken by the computer"
      input = gets.chomp
      until input.match?(/^[1-6]{4}$/)
        puts "Your 'code' must be 4 digits, between 1-6"
        input = gets.chomp
      end
      input.split('')
    end
  end
end

Game.run if $PROGRAM_NAME == __FILE__
