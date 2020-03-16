class BoggleService

  def startGame()

    p 'Boggle Game Starting'
    characters = Array['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
    create4By4Matrix
  end

  def create4By4Matrix()

    column = Array.new
    4.times do
      row = Array.new
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

    def getRandomLetter()
    (65 + rand(0..25)).chr
  end


  def saveWord(params)
    word = params.word
    validateWord(word)
  end

  def validateWord(word)
    bg = Boggle::Boggle.getInstance
    bg.validateWord(word)
  end

  def setNeighbourhoodHash=(value)
    bg = Boggle::Boggle.getInstance
    bg.setNeighbourhoodHash = value
    puts bg.getNeighbourhoodHash
  end
end