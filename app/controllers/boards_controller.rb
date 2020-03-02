class BoardsController < ApplicationController


  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    content = @board.content
    data = JSON.parse(content)  # <--- no `to_json`
    @cells = data["cells"]

    #prints to terminal
    @cells.each {|row| print("#{row}\n")}



  end

end




'{cells : [[0,1,0], [0,0,1], [1,1,1], [0,0,0]]}'

