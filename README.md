# Ruby Mastermind #
Mastermind project from [Odin Project](https://www.theodinproject.com/lessons/ruby-mastermind)

## Game ##
Mastermind is a code breaking game. Guess the order of the numbers to win!

A code is entered into the board for a player to guess. 

In this version, you can play as the CODE-BREAKER, or CODE-MAKER.

### Code-Breaker: ###
  - You have 12 turns to figure out the combination of a randomly generated 4 digit 'code' between 1 - 6.
  - Each turn, you input a guess, and try to use the clues provided to find your next guess.

### Code-Maker: ###
  - You will enter in a 'code'. The code must be 4 digits, between 1 - 6. Digits may be repeated.
  - The AI has 12 turns to figure out your code.
  - It is loosely based on Donald Knuth's [Mastermind algorithm](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Algorithms_and_strategies)
  - The algorithm in this game is not as optimized, but the AI will generally solve a code within 5 to 7 turns.

### Clues / Symbols ###
- **:green_circle:**: Represents number of digits that are the **correct** number and **correct** position.
- **:red_circle:**: Represents number of digits that are the **correct** number, but **wrong** position.
- **:o:**: Represents number of digits that are **misses**.

### Play ###
Head to [repl.it](https://replit.com/@KenTohara/rubyMastermind)

Press the green run button at the top of the page.

[![Run on Repl.it](https://repl.it/badge/github/KTohara/ruby_Mastermind)](https://replit.com/@KenTohara/rubyMastermind)