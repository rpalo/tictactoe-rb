require_relative 'spot'

module TicTacToe
  class Enemy 

    def move(board)
      # Move takes a Board object and returns a spot object
      raise NotImplementedError,
        "You need to define a move strategy for this enemy"
    end
  end

  # Enemy that returns the first available spot
  # reading from top to bottom, left to right
  class BasicEnemy < Enemy

    def move(board)
      board.rows.each.with_index do |row, i|
        row.each.with_index do |cell, j|
          return Spot.new(row: i + 1, col: j + 1) if cell == nil
        end
      end
    end

  end

  # Enemy that keeps trying a random spot until one works
  class RandomEnemy < Enemy

    def move(board)
      loop do
        row = rand(1..3)
        col = rand(1..3)
        return Spot.new(row: row, col: col) if board.open?(row: row, col: col)
      end
    end

  end
end