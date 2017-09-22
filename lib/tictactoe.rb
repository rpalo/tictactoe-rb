
require_relative 'tictactoe/spot'

# Basic Game Controller for Tic Tac Toe
class TicTacToe
  ALLOWED_MARKS = [:x, :o]
  NEXT_MOVER = { :x => :o, :o => :x }
  ALLOWED_SPOTS = (1..3)

  def initialize(enemy=nil)
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil],
    ]
    @empties = @board.length * @board.first.length
    @current = :x
    @enemy = enemy
  end

  def mark(value, spot)
    unless ALLOWED_MARKS.include? value
      raise ArgumentError, "#{value} not an allowed mark"
    end
    unless (ALLOWED_SPOTS.include?(spot.row) && ALLOWED_SPOTS.include?(spot.col))
      raise ArgumentError, "#{spot} is not within the allowed board"
    end
    raise ArgumentError, "#{spot} already taken" if @board[spot.row - 1][spot.col - 1]
    @board[spot.row - 1][spot.col - 1] = value
    @empties -= 1
  end

  def row(n)
    @board[n - 1]
  end

  def col(n)
    @board.map { |row| row[n - 1] }
  end

  def right_diag
    (0..2).map { |index| @board[index][index] }
  end

  def left_diag
    (0..2).map { |index| @board[2 - index][index] }
  end

  def winner
    ALLOWED_MARKS.each do |mark|
      ALLOWED_SPOTS.each do |index|
        if row(index).all? { |item| item == mark }
          return [true, mark]
        elsif col(index).all? { |item| item == mark }
          return [true, mark]
        elsif right_diag.all? { |item| item == mark }
          return [true, mark]
        elsif left_diag.all? { |item| item == mark }
          return [true, mark]
        end
      end
    end
    [false, nil]
  end

  def player_input
    loop do
      puts "Input <row>, <column> to play."
      input = gets
      numbers = input.scan(/[0-9]/)
      if numbers.length == 2
        return Spot.new(row: numbers[0].to_i, col: numbers[1].to_i)
      end
    end
  end

  def play
    while @empties > 0 && winner[0] == false
      if @current == :x or @enemy == nil
        mark @current, player_input
      else
        mark @current, @enemy.move
      end
    end
    winner[1]
  end
end

