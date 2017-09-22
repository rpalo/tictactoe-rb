# A spot on a tic tac toe board
class Spot
  attr_accessor :row, :col
  def initialize(row, col)
    @row = row
    @col = col 
  end
end

TOP_LEFT = Spot.new(1, 1)
TOP_MIDDLE = Spot.new(1, 2)
TOP_RIGHT = Spot.new(1, 3)
MIDDLE_LEFT = Spot.new(2, 1)
MIDDLE_MIDDLE = Spot.new(2, 2)
MIDDLE_RIGHT = Spot.new(2, 3)
BOTTOM_LEFT = Spot.new(3, 1)
BOTTOM_MIDDLE = Spot.new(3, 2)
BOTTOM_RIGHT = Spot.new(3, 3)