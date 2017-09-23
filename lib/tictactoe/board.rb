require_relative 'spot'

module TicTacToe
  class FullBoardError < StandardError
  end

  class Board
    ALLOWED_MARKS = [:x, :o]
    ALLOWED_SPOTS = (1..3)

    attr_reader :empties

    def initialize
      @board = [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil],
      ]
      @empties = @board.length * @board.first.length
    end

    def mark(value, spot)
      unless ALLOWED_MARKS.include? value
        raise ArgumentError, "#{value} not an allowed mark"
      end
      unless (ALLOWED_SPOTS.include?(spot.row) && ALLOWED_SPOTS.include?(spot.col))
        raise ArgumentError, "#{spot} is not within the allowed board"
      end
      if @empties < 1
        raise FullBoardError
      end
      if @board[spot.row - 1][spot.col - 1]
        raise ArgumentError, "#{spot} already taken"
      end

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

  end
end