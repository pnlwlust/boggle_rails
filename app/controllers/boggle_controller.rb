class BoggleController < ApplicationController

  def index

    # boggleService = BoggleService.new()
    # matrix = boggleService.startGame
    # render :json => matrix
  end

  def getMatrix

    boggleService = BoggleService.new()

    matrix = boggleService.startGame
    render json: matrix
  end

  def saveWord
    params = request.body.read
    json = JSON.parse(params)
    boggleService = BoggleService.new

    result = boggleService.saveWord(json)
    render json: { validated: result }
  end

  def getScore
    boggleService = BoggleService.new

    result = boggleService.getFinalResult
    puts "##################################Final Score is##############################"
    puts result

    render json: result
  end

  def test
    render json: "Hello Test From Controller"
  end
end