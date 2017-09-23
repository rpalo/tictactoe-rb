require_relative 'spot'
require_relative 'board'

module TicTacToe
  class Game
    NEXT_MOVER = { :x => :o, :o => :x }

    def initialize(enemy=nil)
      @board = Board.new
      @current = :x
      @enemy = enemy
    end

    def winner
      @board.winner
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

    def mark(value, spot)
      @board.mark(value, spot)
    end

    def play
      while @board.empties > 0 && winner[0] == false
        begin
          if @current == :x or @enemy == nil
            mark @current, player_input
          else
            mark @current, @enemy.move(@board)
          end
        rescue ArgumentError, FullBoardError => e
          puts e
          retry
        end
        @current = NEXT_MOVER[@current]
      end
      winner[1]
    end

  end
end