board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  dashes = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts dashes
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts dashes
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  user_input = user_input.to_i
  user_input = user_input - 1
end


def position_taken?(array, index)
  if array[index] == " " || array[index] == "" ||  array[index] == nil
    return false
  elsif  array[index] == "X" || array[index] == "O"
    return true
  end
end


def valid_move?(board, index)
  if position_taken?(board, index)
    return nil
  elsif index > 8 || index < 0
    return nil
  else
    return true
  end
end


def turn_count(board)
  counter = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
    if turn_count(board) == 0 || turn_count(board) % 2 == 0
      return "X"
    else
      return "O"
    end
end


def move(board, index, value)
  board[index] = value
end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end



WIN_COMBINATIONS = [
  [0,1,2], # 0 - top row win
  [3,4,5], # 1- middle row win
  [6,7,8], # 2 - bottom row win
  [0,3,6], # 3 - left column win
  [1,4,7], # 4 - Middle column win
  [2,5,8], # 5 - right column win
  [0,4,8], # 6 - top left bottom right diagonal win
  [6,4,2], # 8 - bottom left top right diagonal win
]


def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  end
  return false
end

def winner(board)
  win_combo = won?(board)
  if win_combo == false
    return nil
  elsif board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
    return "X"
  elsif  board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
    return "O"
  end
end


def full?(board)
  board.all?{|cell| cell != " "}
end


def draw?(board)
  if won?(board)
    return false
  else
    if full?(board)
      return true
    else
      return false
    end
  end
end



def over?(board)
  if won?(board)
    return true
  elsif full?(board)
    return true
  elsif draw?(board)
    return true
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
