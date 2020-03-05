
#Conways game class

class ConwaysGame
  attr_accessor :board, :initial_board, :alive_count, :dead_count

  #Board --> 2D Array
  def initialize(board)
    @board = get_cells_from_board_model(board)
    #duplicates board to a version that will not change
    @initial_board = Marshal.load(Marshal.dump(@board))
    @initial_board.freeze
    @alive_count = 0
    @dead_count = 0
    @stay_alive_count = JSON.parse(board.stay_alive_count)
    @revive_count = JSON.parse(board.revive_count)

    #*Design Choice
    # When a board is first initialized, the rails DB will already have populated the alive and dead
    # count for that board. As a result, to save one iteration, alive_count and dead_count will only
    # be computed when "next_generation" is called, since the counts here are what we care about

  end

  #alters board to next generation
  # Also completely computes how many alive and dead cells exist in the new iteration of the board - as opposed to
  # simply checking where they were swapped and using those to calculate the new countes(refer to above
  # explanation for justification)
  def next_generation

    @alive_count = 0
    @dead_count = 0
    neighbors_board = ConwaysGame.create_neighbor_board(@board)
    @board.length.times do |row|
      @board[row].length.times do |col|
        num_neighbors = neighbors_board[row][col]

        if @board[row][col] == 1
          # if num_neighbors < 2 || num_neighbors > 3
          # A cell should die if it's # of neighbors does not correspond to the amount needed to stay alive
          if !@stay_alive_count.include?(num_neighbors)
            @board[row][col] = 0
            #Updates alive and dead count
            @dead_count += 1
          else
            @alive_count += 1
          end

        elsif @board[row][col] == 0
          # if num_neighbors == 3
          if @revive_count.include?(num_neighbors)
            @board[row][col] = 1
            #Updates alive and dead count
            @alive_count += 1
          else
            @dead_count += 1
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
          if board[row - 1][col - 1] == 1
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


  def get_cells_from_board_model(board)
    current_state = board.current_state
    data = JSON.parse(current_state)
    cells = data["cells"]
    return cells
  end

end
#
# x = ConwaysGame.new([
#                         [0,1,0],
#                         [0,0,1],
#                         [1,1,1],
#                         [0,0,0]
#                     ])
#
# print(x.board)
# print("\n")
# x.next_generation
# puts("alive:#{x.alive_count}")
# puts("dead: #{x.dead_count}")
# print(x.board)

