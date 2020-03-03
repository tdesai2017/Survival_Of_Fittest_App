require_relative '../conways_game'
class BoardsController < ApplicationController


  def index
    @boards = Board.all
  end

  def new
    @boards
  end

  def show
    @board = Board.find(params[:id])
    current_state = @board.current_state
    data = JSON.parse(current_state)  # <--- no `to_json`
    @cells = data["cells"]


    #prints to terminal
    # @cells.each {|row| print("#{row}\n")}
  end

  def next_state
    @board = Board.find(params[:id])
    current_state = @board.current_state
    data = JSON.parse(current_state)  # <--- no `to_json`
    cells = data["cells"]

    #Gets next iteration of board according to rules
    cg_instance = ConwaysGame.new(cells)
    cg_instance.next_generation
    cells = cg_instance.board
    new_board = {"cells" => cells }

    #Converts board to JSON Rep to save to db
    new_board = new_board.to_json

    print("\n#{new_board}\n")

    #inital board
    # {"cells":[[0,1,0],[0,0,1],[1,1,1],[0,0,0]]}

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

    current_state = @board.current_state
    data = JSON.parse(current_state)  # <--- no `to_json`
    cells = data["cells"]

    row_to_change = coordinates["row"].to_i
    col_to_change = coordinates["col"].to_i

    if cells[row_to_change][col_to_change] == 0
      cells[row_to_change][col_to_change] = 1
    else
      cells[row_to_change][col_to_change] = 0
    end

    cells = {"cells" => cells}.to_json
    print(cells)
    @board.current_state = cells
    @board.generation = 0
    @board.save
    redirect_to @board


  end

end
