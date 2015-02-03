#negamax_ttt

##Description
This is a ruby gem that provides an engine for playing tic tac toe with multiple UIs. It includes mechanisms for setting up and running a game with various sized boards and difficulty levels.

##How to Use
To use this gem, add it to your gemfile and run `bundle install`. 

Set up a user interface and pass it to `Configuration.new`, calling `configure_game` on the object returned to set up a runner.  Call `.run` on the runner to execute the game. 

See "Necessary UI Methods" below for information regarding UI requirements for using this gem.

##How to Test
To run all of the tests, navigate to the project directory and type `rake test`.

To run an individual test, navigate to the project directory and type `ruby/<file_path>`.

##Versions
This gem was put together with Ruby 2.1.2 and Minitest. You may need to work with the same version(s) in order for all features to work properly.

##Necessary UI Methods
This gem encompasses all of the necessary game logic to get an unbeatable tic tac toe game up and running. To make use of it, however, you'll need to implement a set of UI methods to provide data to the logic engine. What follows is a brief description of each necessary UI method. Note that this list contains only those methods which are absolutely necessary for the program to run; additional methods may be added to introduce new features. 

#####UI#get_game_configuration()
Returns a hash with the required board side length, player types, and player move signatures in the format of: 
`{ board_side_length: *int*, player_1: { type: *sym*, move_signature: *char* }, player_2: { type: *sym*, move_signature: *char* } }`. 
The symbols indicating player type must be either `:human_player`, `:beatable_ai_player`, or `:unbeatable_ai_player`.

#####UI#describe_board_configuration(board)
Takes a board object and displays the board with indexes.

#####UI#display_board(board)
Takes a board object and displays the current state of the board with player moves.

#####UI#request_move()
Prompts the user to select their next move.

#####UI#get_validated_input(move_prompt, valid_moves)
Takes two procs/lambdas: (1) a promt (e.g. request_move()), and (2) a condition that validates user input (e.g. checks that a move selected by the user corresponds to an open space). Returns the validated input entered by the user. 

#####UI#announce_outcome(winner)
Takes the game winner. Announces tie game if winner == :tie; otherwise announces game winner.

#####UI#play_again?()
Returns a boolean indicating whether another game should be initiated. `true` begins another game and `false` closes the program.

##Example Implementation
To see an example command line implementation of tic tac toe using this gem, check out https://github.com/rmulhol/ruby_tic_tac_toe