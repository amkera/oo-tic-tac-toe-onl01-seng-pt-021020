class TicTacToe
    #bin file is an executable file
    #whenever you're trying to connect files in the same app, you require_relative 
    WIN_COMBINATIONS = [
            [0, 1, 2], 
            [3, 4, 5], 
            [6, 7, 8], 
            [0, 3, 6], 
            [1, 4, 7], 
            [2, 5, 8], 
            [0, 4, 8], 
            [2, 4, 6]
    ]
    
    def initialize(board = nil)
        #if you see a .new with no arguments, like .new = ("something), in the spec, it means you need an initialize method with NO arguments.
        @board = board || Array.new(9, " ")
    end 

    def display_board #instance method, since the spec didn't ask for a .display_board. It asked for a #display_board.
        #spec didn't ask for an argument, so no argument
        puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
        puts "-----------"
        puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
        puts "-----------"
        puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
    end

    def input_to_index(user_input) #string_input
        user_input.to_i - 1
        #convert string to integer, subtract 1 to match index
    end 

    def move(slot, user_input = "X") 
        #center of our world is based on the @board instance variable. 
        #need to relate the X player, the O player, 
        @board[slot] = user_input
        #file doesn't know about subtracting 1 just yet. 
    end 

    def position_taken?(slot) #question marks mean boolean return value
        #if it's taken, we want to return true
        @board[slot] == "X" || @board[slot] == "O" ? true : false
        #@board[index] == " " ? false : true  #ternary operator
            #return false 
        #else
            #return true 
    end

    def valid_move?(slot)
        #this is the inverse of position_taken?
        slot.between?(0,8) && !(self.position_taken?(slot))
        #will automatically return true if both of these are true
    end 

    def turn_count
        counter = 0
        @board.each do |slot|
            if slot == "X" || slot == "O"
                count += 1
            end 
        end 
        counter
    end 
    

    def current_player
        turn_count % 2 == 0 ? player = "X" : player = "O"
    end 


    def turn
        puts "Welcome! Please input a number between 1 and 9:" 
        user_input = gets.chomp #asking user for 1-9
        slot = input_to_index(user_input)
        if valid_move?(slot)
            selection = current_player
            move(slot, selection)
            display_board
        else 
            turn 
        end 
    end 

    #puts user_input
        #index = self.input_to_index(user_input)

       # token = self.current_player

        #if self.valid_move?(index) #if it's a valid move,
            #self.move(index, token) #let's move
            #self.display_board #and display the board 
        #else 
            #self.turn
        #end 
    #end    
    

    def play
        turn until over?
        if self.won?
            puts "Congratulations #{winner}!"
        elsif self.draw?
            puts "Cat's Game!"
        else
            puts "Goodbye."
        end
    end 


    def won?
        win_combo = nil #asks to return the winning combination at the end, set to nil for now because this value is only going to get reset if we have a winning combination. 
        WIN_COMBINATIONS.each do |array|
            if @board[array[0]] == @board[array[1]] && @board[array[1]] == @board[array[2]] && position_taken?(array[0])
                win_combo = array 
            end
        end 
        win_combo #returns an array of indexes, or nil 
    end 


    def full? 
        !@board.any?{|position| position == "" || position == " "}

        #or @board.all?{|position| position == "X" || position == "O"}
    end 


    #returns true for a draw 
    #returns false for an in-progress game
    def draw? 
        #return true for a draw 
        #return false if one person wins, returns false if in progress 
        !(self.won?) && self.full? 
        #we need to negate self.won because it returns Nil if there's no winning combination.  

        #will work without self (but GOOD TO USE IT!)
        #this is an instance method, and the game object is what it's being called on 
    end 

    def over? 
        self.draw? || self.won?
    end 

    def winner
        @board[self.won?[0]] if self.won? #this gives either the X or the O back to us
        #value of self.won? is an array of indexes, or nil  
    end 
end




