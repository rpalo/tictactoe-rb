

module TicTacToe
  class Enemy 

    def move(board)
      raise NotImplementedError,
        "You need to define a move strategy for this enemy"
    end
  end
end