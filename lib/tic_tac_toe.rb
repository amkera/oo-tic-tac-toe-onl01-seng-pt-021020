class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(choice)
    choice.to_i - 1
  end

  def move(slot, choice = "X")
    @board[slot] = choice
  end

  def position_taken?(slot)
    @board[slot] == "X" || @board[slot] == "O" ? true : false
  end

  def valid_move?(slot)
    slot.between?(0,8) && !(self.position_taken?(slot))
  end

  def turn_count
    count = 0
    @board.each do |slot|
      if slot == "X" || slot == "O"
        count += 1
      end
    end
    count
  end

  def current_player
    turn_count % 2 == 0 ? player = "X" : player = "O"
  end

  def turn
    puts "Welcome: Please input a number between 1 and 9:"
    choice = gets
    slot = input_to_index(choice)
    if valid_move?(slot)
      selection = current_player
      move(slot, selection)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
        if ((@board[combo[0]]) == "X" && (@board[combo[1]]) == "X" && (@board[combo[2]]) == "X") || ((@board[combo[0]]) == "O" && (@board[combo[1]]) == "O" && (@board[combo[2]]) == "O")
         return combo
       else
        false
      end
    end
  end

  def full?
    @board.all? {|slot| slot == "X" || slot == "O"}
  end

  def draw?
    !won? && full? ? true : false
  end

  def over?
    won? || draw? ? true : false
  end

  def winner
    WIN_COMBINATIONS.detect do |combo|
        if ((@board[combo[0]]) == "X" && (@board[combo[1]]) == "X" && (@board[combo[2]]) == "X")
          return "X"
        elsif ((@board[combo[0]]) == "O" && (@board[combo[1]]) == "O" && (@board[combo[2]]) == "O")
         return "O"
       else
        false
      end
    end
  end

  def play
    turn until over?
    if self.won?
        puts "Congratulations #{winner}!"
    elsif self.draw?
        puts "Cat's Game!"
    else
      puts "That was fun, see you next time."
    end
  end
end

