class TicTacToe
    def initialize
      @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    #initialize the very first state that the board will be in
    #in this case, 9 empty strings in an array
  
    WIN_COMBINATIONS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    #each puts in display_board is interpolating the instance/index position of the empty string in 'board'
    #does what it's supposed to do: displays the board in the console
  
    def input_to_index(user_input)
      user_input.to_i - 1
    end

    #input_to_index takes in whatever the user puts in and minuses 1 so that it matches the index of the array
  
    def move(index, token)
      @board[index] = token
    end

    #set the @board instance equal to the token being put in 

  
    def position_taken?(index)
      @board[index] != " "
    end

    #checks if the position is taken if the string is empty or not
  
    def valid_move?(index)
      !position_taken?(index) && index.between?(0,8)
    end

    #checks if the position is empty, and checks to see if the position/index is between 0 and 8
  
    def turn_count
      @board.count{|square| square != " " }
    end

    #The count method in Ruby is used to check the length of an array. 
    #The length of an array is the number of elements the array contains.

    #act on each element of the array, call it square. see if square does not equal to an empty string
  
    def current_player
      turn_count.even? ? "X" : "O"
    end

    #keeps track of the current player and what token should be used to denote their input
    #X or O

  
    def turn
      puts "Please enter a number (1-9):"
      user_input = gets.strip
      index = input_to_index(user_input)
      if valid_move?(index)
        token = current_player
        move(index, token)
      else
        turn
      end
      display_board
    end

    #prints out asking for user input
    #user_input gets defined and takes in whatever is entered into the console. uses `gets`
    # the index is set equal to the user input minus one. done by calling input_to_index and passing in user_input
    #where user_input is whatever got entered and then was stripped of spaces
    
    #if the move is valid (we call it by invoking valid_move on index)
    #the token is equal to the return of the valid_move ternary, X or O
    #move then acts on the given index, and the token given back from valid_move
    #else, invoke turn
    #and at the very end, display the board 
  
    def won?
      WIN_COMBINATIONS.any? do |combo|
        if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
          return combo
        end
      end
    end

    #the question mark turns it into a true/false return automatically
    #The any?() of enumerable is an inbuilt method in 
    #Ruby returns a boolean value if any of the object in the enumerable satisfies the given condition, 
    #else it returns false.

    #go through WIN_COMBINATIONS, and check each element to see if it satisfies the conditions
    #if the position is taken, then check if the passed in combo matches the populated indexes
    #if it does, return the combo 
  
    def full?
      @board.all?{|square| square != " " }
    end

    #go through the whole board and see if it's full or not
  
    def draw?
      full? && !won?
    end

    #is the board full and it hasn't been won? It will be a draw
  
    def over?
      won? || draw?
    end

    # is the game over? did someone win? or there a draw? 
  
    def winner
      if combo = won?
        @board[combo[0]]
      end
    end

    # did the combo result in a win? 
    # does the instance of board match the instance of the winning combo?
  
    def play
      turn until over?
      puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

    #play by invoking turn until the condition of over is true
    # once winner returns true, aka there is a winner, print out either a congratulations or a draw

  end
