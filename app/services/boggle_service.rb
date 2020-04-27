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

  def saveWords(params)
    wordList = params['words']

    wordList.each do |word|
      puts "New Word: ", word
      saveWord(word)
    end
  end

  def saveWord(word)
    # word = params['word']
    puts word
    return validateWord(word)
  end

  def validateWord(word)
    bg = Boggle::Boggle.getInstance
    if validateAgainstDictionary(word) && validateAgainstNeighbourhoodLetters(word)
      puts "Keeping Score"
      puts bg.keepScore(word) #keep score if validated
      return true
    end
    return false
  end

  def validateAgainstNeighbourhoodLetters(word)
    bg = Boggle::Boggle.getInstance
    bg.validateAgainstNeighbourhoodLetters(word)
  end

  def validateAgainstDictionary(word)
    bg = Boggle::Boggle.getInstance
    bg.validateAgainstDictionary(word)
  end

  def setNeighbourhoodHash=(value)
    bg = Boggle::Boggle.getInstance
    bg.setNeighbourhoodHash = value
    puts bg.getNeighbourhoodHash
  end

  def getFinalResult
    validWords = getValidWords
    score = getScore
    { validWords: validWords, score: score }
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
