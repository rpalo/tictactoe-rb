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

  # Enemy that tries to stop the player from getting 3
  class DefensiveEnemy < Enemy

    def move(board)
      board.rows.each.with_index do |row, i|
        if row.count(:x) == 2 && row.count(nil) == 1
          return Spot.new(row: i + 1, col: row.index(nil) + 1)
        end
      end
      board.cols.each.with_index do |col, j|
        if col.count(:x) == 2 && col.count(nil) == 1
          return Spot.new(row: col.index(nil) + 1, col: j + 1)
        end
      end
      rd = board.right_diag
      ld = board.left_diag
      if rd.count(:x) == 2 && rd.count(nil) == 1
        ind = rd.index(nil)
        return Spot.new(row: ind + 1, col: ind + 1)
      end
      if ld.count(:x) == 2 && ld.count(nil) == 1
        ind = ld.index(nil)
        return Spot.new(row: 3 - ind, col: ind + 1)
      end

      # Otherwise behave like basic
      board.rows.each.with_index do |row, i|
        row.each.with_index do |cell, j|
          return Spot.new(row: i + 1, col: j + 1) if cell == nil
        end
      end
    end

  end
end