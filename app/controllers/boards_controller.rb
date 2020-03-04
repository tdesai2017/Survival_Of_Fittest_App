require_relative '../conways_game'
class BoardsController < ApplicationController


  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @cells = get_current_board_cells(@board)
  end

  def create
    new_board = {"current_state" => '{"cells":[[0,1,0],[0,0,1],[1,1,1],[0,0,0]]}',
                 "initial_state" => '{"cells":[[0,1,0],[0,0,1],[1,1,1],[0,0,0]]}',
                 "generation" => 0
                }
    @board = Board.new(new_board)
    @board.save
    redirect_to boards_path
  end

  #Automatically get access to the respective ID since we are redirecting
  # from a "show" page
  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
  end

  def save_as_initial_state
    @board = Board.find(params[:id])
    @board.initial_state = @board.current_state
    @board.save
    redirect_to board_path

  end

  def next_state
    @board = Board.find(params[:id])
    @cells = get_current_board_cells(@board)

    #Gets next iteration of board according to rules
    cg_instance = ConwaysGame.new(@cells)
    cg_instance.next_generation
    cells = cg_instance.board
    new_board = {"cells" => cells }

    #Converts board to JSON Rep to save to db
    new_board = new_board.to_json

    #sets board's current_state to include new current_state
    @board.current_state = new_board
    @board.generation = @board.generation + 1
    @board.save

    redirect_to @board
  end

  #restarts the state of the current board
  def restart_state
    @board = Board.find(params[:id])
    initial_state = @board.initial_state
    @board.current_state = initial_state
    @board.generation = 0
    @board.save
    redirect_to @board
  end

  #Careful with the security implications of using "Eval" --> everything inside
  # it will be evaluated = can be dangerous if someone sends a rogue request in
  def flip_cell
    @board = Board.find(params[:id])

    #converts given json string into a workable hash
    # string comes in the form of {"row"=>0, "col"=>1}
    # represent coordinates of cell we will flip
    coordinates = eval(params[:coordinates])

    cells = get_current_board_cells(@board)


    row_to_change = coordinates["row"].to_i
    col_to_change = coordinates["col"].to_i

    if cells[row_to_change][col_to_change] == 0
      cells[row_to_change][col_to_change] = 1
    else
      cells[row_to_change][col_to_change] = 0
    end

    #Creates new hash representation
    cells = {"cells" => cells}.to_json
    @board.current_state = cells
    @board.generation = 0
    @board.save
    redirect_to @board
  end

  def add_col
    @board = Board.find(params[:id])
    cells = get_current_board_cells(@board)
    cells.length.times do |row|
      cells[row] << 0
    end
    cells = {"cells" => cells}.to_json
    @board.current_state = cells
    @board.generation = 0
    @board.save
    redirect_to @board

  end

  def add_row
    @board = Board.find(params[:id])
    cells = get_current_board_cells(@board)
    #Adds a new row at an equal length to the lowest row
    last_row_length = cells[cells.length - 1].length
    new_row = []
    last_row_length.times do
      new_row << 0
    end
    cells << new_row
    cells = {"cells" => cells}.to_json
    @board.current_state = cells
    @board.generation = 0
    @board.save
    redirect_to @board
  end

  def remove_col
    @board = Board.find(params[:id])
    cells = get_current_board_cells(@board)
    #only removes column if the first row has a length > 1
    if cells[0].length > 1
      cells.length.times do |row|
        cells[row].pop
      end
      cells = {"cells" => cells}.to_json
      @board.current_state = cells
      @board.generation = 0
      @board.save
    end
    redirect_to @board
  end

  def remove_row
    @board = Board.find(params[:id])
    cells = get_current_board_cells(@board)
    #only removes row length of board > 1
    if cells.length > 1
      cells.pop
      cells = {"cells" => cells}.to_json
      @board.current_state = cells
      @board.generation = 0
      @board.save
    end
    redirect_to @board
  end

  private

  def get_current_board_cells(board)
    current_state = board.current_state
    data = JSON.parse(current_state)
    cells = data["cells"]
    return cells
  end

end
