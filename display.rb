# frozen_string_literal: true

# Display functions
module Display
  def prompt(message)
    {
      breaker_code: "Enter a 4 digit 'code' using numbers 1-6 for each digit, to be broken by the computer",
      guess: "Make a guess - 4 digits between 1-6 IE: '1234'",
      replay: 'Repeat game? (y)es/(n)o'
    }[message]
  end

  def error(message)
    {
      game_mode: 'Enter (1) to be a code BREAKER, (2) to be a code MAKER',
      code_error: "Your 'code' must be 4 digits, between 1-6"
    }[message]
  end

  def game_message(message)
    {
      greetings: "Let's play Mastermind!\n" +
        "Press (1) to be a code BREAKER\n" +
        "Press (2) to be a code MAKER\n",
      win: 'The code was guessed!',
      lose: 'The code was not found!',
      thanks: 'Thanks for playing!'
    }[message]
  end

  def show_guess(array, hits)
    system('clear')
    puts "GUESS: #{array.join(' ')}"
    puts "EXACT: #{hits.first} | PARTIAL: #{hits.last}"
  end

  def show_code(code)
    puts code.join(' ').to_s
  end
end
