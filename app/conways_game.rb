
#Conways game class

class ConwaysGame
  attr_accessor :board, :initial_board

  #Board --> 2D Array
  def initialize(board)
    @board = board
    #duplicates board to a version that will not change
    @initial_board = Marshal.load(Marshal.dump(@board))

    @initial_board.freeze

  end

  #alters board to next generation
  def next_generation
    neighbors_board = ConwaysGame.create_neighbor_board(@board)
    @board.length.times do |row|
      @board[row].length.times do |col|
        num_neighbors = neighbors_board[row][col]
        # puts(" #{row} #{col} #{num_neighbors}")

        if @board[row][col] == 1
          if num_neighbors < 2 or num_neighbors > 3
            @board[row][col] = 0
          end

        elsif @board[row][col] == 0
          if num_neighbors == 3
            @board[row][col] = 1
          end

        end
      end
    end
    #we just want it to mutate the board now
    # return (@board)
    #

  end

  private

  #used by get_next_generation
  # #takes in a board  + returns the neighbors
  # #static method
  def self.create_neighbor_board(board)
    neighbor_board = []
    board.length.times do |row|
      neighbor_board << Array.new(board[row].length)
    end

    board.length.times do |row|
      board[row].length.times do |col|
        live_neighbors = 0
        #up
        if row >= 1
          if board[row - 1][col] == 1
            live_neighbors += 1
          end
        end

        #down
        if row <= board.length - 2
          if board[row + 1][col] == 1
            live_neighbors += 1
          end
        end

        #left
        if col >= 1
          if board[row][col - 1] == 1
            live_neighbors += 1
          end
        end


        #right
        if col <= board[row].length - 2
          if board[row][col + 1] == 1
            live_neighbors += 1
          end
        end

        #top left
        if row >= 1 and col >= 1
          if board[row-1][col-1] == 1
            live_neighbors += 1

          end
        end

        #top right
        if row >= 1 and col <= board[row].length - 2
          if board[row - 1][col + 1] == 1
            live_neighbors += 1
          end
        end

        #bottom left
        if row <= board.length - 2 and col >= 1
          if board[row + 1][col - 1] == 1
            live_neighbors += 1
          end
        end


        #bottom right
        if row <= board.length - 2 and col <= board[row].length - 2
          if board[row + 1][col + 1] == 1
            live_neighbors += 1
          end
        end
        neighbor_board[row][col] = live_neighbors
      end
    end
    return(neighbor_board)
  end


  def reset_board
    @board = Marshal.load(Marshal.dump(@initial_board))
  end
end


#
# x = ConwaysGame.new([
#                         [0,1,0],
#                         [0,0,1],
#                         [1,1,1],
#                         [0,0,0]
#                     ])

# print(x.board)
# print("\n")
# x.next_generation
# print(x.board)



[[0,1,0],[0,0,1],[1,1,1],[0,0,0]]





# '{cells : [[0,1,0], [0,0,1], [1,1,1], [0,0,0]]}'

