# frozen_string_literal: true

require_relative 'color'

# Display functions
module Display
  TOP_L  = "\u256D" # ╭
  TOP_R  = "\u256E" # ╮
  BOT_L  = "\u2570" # ╰
  BOT_R  = "\u256F" # ╯
  HORI   = "\u2500" # ─
  VERT   = "\u2502" # │
  JOIN_D = "\u252C" # ┬
  JOIN_U = "\u2534" # ┴
  JOIN_R = "\u251C" # ┤
  JOIN_L = "\u2524" # ├
  JOIN_A = "\u253C" # ┼

  def top_row
    TOP_L + HORI * 13 + JOIN_D + HORI * 9 + TOP_R
  end

  def divider_row
    JOIN_R + HORI * 13 + JOIN_A + HORI * 9 + JOIN_L
  end

  def bottom_row
    BOT_L + HORI * 13 + JOIN_U + HORI * 9 + BOT_R
  end

  def game_row(guess, hits)
    hit_types = ['exact', 'partial', 'empty']
    disp_guess = guess.map { |num| pegs(num) }.join(' ')
    disp_hits = hits.map.with_index { |num, i| ("#{hits(hit_types[i])} " * num).rstrip }.join(' ')
    "#{VERT} #{disp_guess} #{VERT} #{disp_hits} #{VERT}"
  end

  def pegs(number)
    {
      'empty' => "\uFF2F".black,
      '1' => "\uFF11".red,
      '2' => "\uFF12".green,
      '3' => "\uFF13".blue,
      '4' => "\uFF14".purple,
      '5' => "\uFF15".cyan,
      '6' => "\uFF16".yellow
    }[number]
  end

  def hits(type)
    {
      'exact' => "\u25CF".pink,
      'partial' => "\u25CB".pink,
      'empty' => "\u25CC"
    }[type]
  end

  def prompt(message)
    {
      breaker_code: "Enter a 4 digit 'code' using numbers 1-6 for each digit, to be broken by the computer",
      guess: "Make a guess - 4 digits between 1-6 IE: '1234'",
      replay: 'Repeat game? (y)es/(n)o'
    }[message]
  end

  def error(message)
    {
      game_mode: 'Enter (1) to be a code BREAKER, (2) to be a code MAKER'.red,
      code_error: "Your 'code' must be 4 digits, between 1-6".red
    }[message]
  end

  def game_message(message)
    {
      greetings: "Let's play Mastermind!\n" \
        "Press (1) to be a code BREAKER\n" \
        "Press (2) to be a code MAKER\n",
      show_code: 'Your code has been recorded',
      win: 'The code was guessed!'.red,
      lose: 'The code was not found!'.red,
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
