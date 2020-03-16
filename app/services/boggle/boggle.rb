module Boggle
  class Boggle

    @boggleInstance
    def initialize()
      @neighboursHash = Hash.new
    end

    def setNeighbourhoodHash=(value)
      @neighboursHash = value
    end

    def getNeighbourhoodHash()
      return @neighboursHash
    end

    def self.getInstance()

      if !@boggleInstance
        @boggleInstance = Boggle.new
      end
      return @boggleInstance
    end

    def start()
      p "Boggle Game Starting"
      characters = Array['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
      puts characters.length
      "Hello World"
    end

    def createNeghbouringMap(column)

      totalLength = column.length
      for i in  (0..totalLength-1)
        for j in  (0..totalLength-1)
          currentElement = column[i][j]
          addNeighbouringElements(currentElement, fetchNeghbouringElements(i, j, column))
        end
      end

      @neighboursHash
    end

    def addNeighbouringElements(currentElement, neighbouringElements)
      oldSet = @neighboursHash[currentElement]
      if(oldSet)
        oldSet.merge(neighbouringElements)
      else
        oldSet = neighbouringElements
      end

      @neighboursHash[currentElement] = oldSet
    end

    def fetchNeghbouringElements(rowIndex, columnIndex, totalElements)
      totalLength = totalElements.length
      columnIndexMax = (columnIndex + 1) < totalLength ? (columnIndex + 1) : columnIndex
      columnIndexMin = (columnIndex - 1) < 0 ? columnIndex : (columnIndex - 1)
      rowIndexMax = (rowIndex + 1) < totalLength ? (rowIndex + 1) : rowIndex
      rowIndexMin = (rowIndex - 1) < 0 ? rowIndex : (rowIndex - 1)
      neighbourArray = Set.new
      # puts "[%d %d] - [%d %d]" % [rowIndexMin, columnIndexMin, rowIndexMax, columnIndexMax]
      for i in  (columnIndexMin..columnIndexMax)
        for j in  (rowIndexMin..rowIndexMax)
          neighbourArray.add(totalElements[j][i])
        end
      end
      neighbourArray
    end

    def validateWord(word)
      puts word
      wordLength = word.length
      for i in (0..wordLength-1)
        if(i == wordLength-1)
          next
        end
        ch = word[i].upcase
        neighbouringElements = @neighboursHash[ch]
        puts "%d %s : %s"  % [i, ch, neighbouringElements]
        secondWord = word[i+1]
        if(!neighbouringElements || !secondWord )
          return false
        end
        if(!neighbouringElements.include?(secondWord.upcase))
          return false
        end
      end
      true
    end
  end
end