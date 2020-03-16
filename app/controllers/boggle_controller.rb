class BoggleController < ApplicationController

  def index

    BoggleService boggle = BoggleService.new()
    matrix = boggle.startGame()
    render :json=[matrix:matrix]
  end

  def saveWord
    BoggleService.saveWord
  end
end