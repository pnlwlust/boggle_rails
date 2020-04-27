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

  def saveWord # Call if you need to validate on each word input
    params = request.body.read
    json = JSON.parse(params)
    boggleService = BoggleService.new

    result = boggleService.saveWord(json['word'])
    render json: { validated: result }
  end

  def getScore

    params = request.body.read
    json = JSON.parse(params)

    boggleService = BoggleService.new
    boggleService.saveWords(json)
    result = boggleService.getFinalResult
    puts "##################################Final Score is##############################"
    puts result

    render json: result
  end

  def test
    render json: "Hello Test From Controller"
  end
end