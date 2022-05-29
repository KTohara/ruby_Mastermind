# frozen_string_literal: true

# Display functions
module Display
  def prompt(message)
    {
      guess: 'Make a guess - 4 digits between 1-6',
      replay: 'Repeat game? (y)es/(n)o'
    }[message]
  end

  def error(message)
    {
      guess: 'Guess must be 4 digits between 1-6'
    }[message]
  end

  def game_outcome(message)
    {
      win: 'You win!',
      lose: 'You lose!',
      thanks: 'Thanks for playing!'
    }[message]
  end

  def show_guess(array, hits)
    system('clear')
    puts "GUESS: #{array.join(' ')}"
    puts "EXACT: #{hits.first} | PARTIAL: #{hits.last}"
  end

  def show_code(code)
    puts "#{code.join(' ')}"
  end
end
