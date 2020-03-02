require_relative '../conways_game'
class BoardsController < ApplicationController


  def index
    @boards = Board.all
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
    @board.save

    redirect_to @board
  end

  #restarts the state of the current board
  def restart_state
    @board = Board.find(params[:id])
    initial_state = @board.initial_state
    @board.current_state = initial_state
    @board.save
    redirect_to @board

  end

end
