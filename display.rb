# frozen_string_literal: true

require_relative 'color'

# Display functions
module Display
  TOP_L  = "\u256D".purple # ╭
  TOP_R  = "\u256E".purple # ╮
  BOT_L  = "\u2570".purple # ╰
  BOT_R  = "\u256F".purple # ╯
  HORI   = "\u2500".purple # ─
  VERT   = "\u2502".purple # │
  JOIN_D = "\u252C".purple # ┬
  JOIN_U = "\u2534".purple # ┴
  JOIN_R = "\u251C".purple # ┤
  JOIN_L = "\u2524".purple # ├
  JOIN_A = "\u253C".purple # ┼
  SPACE  = " " * 27

  def top_row
    SPACE + TOP_L + HORI * 15 + JOIN_D + HORI * 9 + TOP_R
  end

  def divider_row
    SPACE + JOIN_R + HORI * 15 + JOIN_A + HORI * 9 + JOIN_L
  end

  def bottom_row
    SPACE + BOT_L + HORI * 15 + JOIN_U + HORI * 9 + BOT_R
  end

  def game_row(guess, hits)
    disp_guess = guess.map { |num| pegs(num) }.join(' ')
    disp_hits = hits.map { |type| hits(type) }.join(' ')

    "#{SPACE}#{VERT}  #{disp_guess}  #{VERT} #{disp_hits} #{VERT}"
  end

  def stats_row(turn, code)
    code_msg = 'CODE'.bold
    turn_msg = 'TURN'.bold
    code_num = code.map { |num| instance_of?(Computer) ? pegs(num) : pegs('?') }.join.green
    turn_num = turn.to_s.ljust(3).green

    "#{SPACE}#{VERT} #{code_msg} #{code_num} #{VERT} #{turn_msg} #{turn_num}#{VERT}"
  end

  def banner
    %q{
    ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗██████╗ 
    ████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗
    ██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║██║  ██║
    ██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██║  ██║
    ██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██████╔╝
    ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝ 
    }.purple
  end

  def pegs(number)
    {
      '_' => "\uFF2F".black,   # Ｏ
      '1' => "\uFF11".yellow,  # １
      '2' => "\uFF12".yellow,  # ２
      '3' => "\uFF13".yellow,  # ３
      '4' => "\uFF14".yellow,  # ４
      '5' => "\uFF15".yellow,  # ５
      '6' => "\uFF16".yellow,  # ６
      '?' => "\uFF1F".green    # ？
    }[number]
  end

  def hits(type)
    {
      'E' => "\u25CF".green, # ●
      'P' => "\u25CF".red,   # ●
      'M' => "\u25CB".pink,  # ○
      '_' => "\u25CC"        # ◌
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
      win: "The code was guessed!\n\n".red,
      lose: "The code was not found!\n\n".red,
      thanks: 'Thanks for playing!'
    }[message]
  end

  def show_code(code)
    puts code.join(' ')
  end
end
