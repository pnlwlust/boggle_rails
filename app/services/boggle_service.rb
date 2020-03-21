# frozen_string_literal: true

class BoggleService

  def startGame
    p 'Boggle Game Starting'
    create4By4Matrix
  end

  def create4By4Matrix
    column = []
    4.times do
      row = []
      4.times do
        row.push(getRandomLetter)
      end
      column.push(row)
    end
    puts column.inspect
    createNeighbouringMap(column)
    column
  end

  def createNeighbouringMap(column)
    bg = Boggle:: Boggle.getInstance
    bg.createNeghbouringMap(column)
  end

  def getRandomLetter
    rand(65..90).chr
  end

  def saveWord(params)
    word = params.word
    validateWord(word)
  end

  def validateWord(word)
    bg = Boggle::Boggle.getInstance
    if bg.validateAgainstDictionary(word) && bg.validateAgainstNeighbourhoodLetters(word)
      bg.keepScore(word)
    end
  end

  def setNeighbourhoodHash=(value)
    bg = Boggle::Boggle.getInstance
    bg.setNeighbourhoodHash = value
    puts bg.getNeighbourhoodHash
  end

  def getFinalResult
    validWords = getValidWords
    score = getScore
    ['validWords' => validWords, 'score' => score]
  end

  def getValidWords
    bg = Boggle::Boggle.getInstance
    bg.getValidWords
  end

  def getScore
    bg = Boggle::Boggle.getInstance
    bg.getScore
  end

end
