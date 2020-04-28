# frozen_string_literal: true

module Boggle
  class Boggle
    @boggleInstance
    def initialize
      @neighboursHash = {}
      @score = 0
      @validWords = Set.new
    end

    def setNeighbourhoodHash=(value)
      @neighboursHash = value
    end

    def getNeighbourhoodHash
      @neighboursHash
    end

    def self.getInstance
      @boggleInstance ||= Boggle.new
      @boggleInstance
    end

=begin
    def start
      p 'Boggle Game Starting'
      characters = Array['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
      puts characters.length
      'Hello World'
    end
=end

    def createNeghbouringMap(column)
      resetOldData() #reseting old neighbourhood hash data
      totalLength = column.length
      (0..totalLength - 1).each do |i|
        (0..totalLength - 1).each do |j|
          currentElement = column[i][j]
          addNeighbouringElements(currentElement, fetchNeghbouringElements(i, j, column))
        end
      end

      @neighboursHash
    end

    def resetOldScore()
      @score = 0
      @validWords = Set.new
    end

    def resetOldData()
      @neighboursHash = {}
    end

    def addNeighbouringElements(currentElement, neighbouringElements)
      oldSet = @neighboursHash[currentElement]
      if oldSet
        oldSet.push(*neighbouringElements)
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
      neighbourArray = Array.new
      # puts "[%d %d] - [%d %d]" % [rowIndexMin, columnIndexMin, rowIndexMax, columnIndexMax]
      (columnIndexMin..columnIndexMax).each do |i|
        (rowIndexMin..rowIndexMax).each do |j|
          neighbourArray.push(totalElements[j][i])
        end
      end
      neighbourArray
    end

    def validateAgainstNeighbourhoodLetters(word)
      puts "Validating against neighbourhood letters: "
      wordLength = word.length
      return false if wordLength < 3 # Mininum 3 letters word required

      p "Chr : Neighbouring Letters"
      (0..wordLength - 1).each do |i|
        next if i == wordLength - 1

        ch = word[i].upcase
        neighbouringElements = @neighboursHash[ch]
        puts format(' %d %s : %s', i, ch, neighbouringElements)
        secondWord = word[i + 1]
        return false if !neighbouringElements || !secondWord
        return false unless neighbouringElements.include?(secondWord.upcase)
      end
      puts "Valid"
      true
    end

    def validateAgainstDictionary(word)
      DictionaryApi.validateWord(word) # Calls expernal Api
    end

    def keepScore(word)
      length = word.length
      @validWords.add(word) # Keeping record of valid words
      case length
      when 0..2
        @score += 0
      when 3, 4
        @score += 1 # 3-4 letters word scores 1
      when 5
        @score += 2 # 5 letters word scores 2
      when 6
        @score += 3 # 6 letters word scores 3
      when 7
        @score += 5 # 7 letters word scores 5
      else
        @score += 11 # >8 letters word scores 11
      end

      @score
    end

    def getValidWords
      @validWords
    end

    def getScore
      @score
    end
  end
end
