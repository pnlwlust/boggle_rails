class BoggleController < ApplicationController

  def index

    BoggleService boggleService = BoggleService.new()
    matrix = boggleService.startGame()
    render :json=[matrix:matrix]
  end

  def saveWord
    BoggleService boggleService = BoggleService.new()
    boggleService.saveWord(params)
  end

  def getFinalResult
    BoggleService boggleService = BoggleService.new()
    boggleService.getFinalResult
  end
end