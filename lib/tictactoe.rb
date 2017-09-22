
require_relative 'tictactoe/spot'

# Basic Game Controller for Tic Tac Toe
class TicTacToe
  ALLOWED_MARKS = [:x, :o]

  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil],
    ]
  end

  def mark(value, spot)
    unless ALLOWED_MARKS.include? value
      raise ArgumentError, "#{value} not an allowed mark"
    end
    @board[spot.row - 1][spot.col - 1] = value
  end

  def row(n)
    @board[n - 1]
  end

  def col(n)
    @board.map { |row| row[n - 1] }
  end
end

