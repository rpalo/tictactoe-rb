# A spot on a tic tac toe board
class Spot
  attr_accessor :row, :col
  def initialize(row:, col:)
    @row = row
    @col = col 
  end
end

TOP_LEFT = Spot.new(row: 1, col:1)
TOP_MIDDLE = Spot.new(row: 1, col: 2)
TOP_RIGHT = Spot.new(row: 1, col: 3)
MIDDLE_LEFT = Spot.new(row: 2, col: 1)
MIDDLE_MIDDLE = Spot.new(row: 2, col: 2)
MIDDLE_RIGHT = Spot.new(row: 2, col: 3)
BOTTOM_LEFT = Spot.new(row: 3, col: 1)
BOTTOM_MIDDLE = Spot.new(row: 3, col: 2)
BOTTOM_RIGHT = Spot.new(row: 3, col: 3)