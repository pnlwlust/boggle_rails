require 'rails_helper'

describe BoggleService do
  before(:all) do
    @boogleService = BoggleService.new
  end
  context 'When Testing the BoggleService class' do

    it 'Start method should return 26' do

      response = @boogleService.startGame()
      expect(response).to eq 26
    end

    it 'should return a random character when called getLetter method' do
      bg = BoggleService.new
      response = bg.getRandomLetter
      expect(response).to match /^[A-Z]$/
    end

    it 'should return array' do

      bg = BoggleService.new
      response = bg.create4By4Matrix
      expect(response).to be_instance_of Array
    end

    it 'should return 4 as length of the array' do

      bg = BoggleService.new
      response = bg.create4By4Matrix
      expect(response.length).to eq 4
    end

  end

  context 'When testing createNeighbouringMap method' do

    before(:each) do
      @column = [
          ['U', 'C', 'K', 'U'],
          ['W', 'L', 'T', 'S'],
          ['R', 'M', 'D', 'G'],
          ['L', 'Y', 'R', 'O']
      ]
    end
    it 'should return map with set of all neighbouring letters' do

      bg = BoggleService.new
      response = bg.createNeighbouringMap(@column)
      pp response
      expect(response).to be_instance_of Hash
      expect(response.length).to eq 13
      expect(response['U']).to be_instance_of Set
    end

    it 'should contain all elements in a matrix as keys' do

      bg = BoggleService.new
      response = bg.createNeighbouringMap(@column)
      expect(response).to have_key('U')
      expect(response).to have_key('C')
      expect(response).to have_key('K')
      expect(response).to have_key('W')
      expect(response).to have_key('L')
      expect(response).to have_key('T')
      expect(response).to have_key('S')
      expect(response).to have_key('R')
      expect(response).to have_key('M')
      expect(response).to have_key('D')
      expect(response).to have_key('G')
      expect(response).to have_key('L')
      expect(response).to have_key('Y')
      expect(response).to have_key('O')
    end

    it 'should contain given letters in the created set' do

      bg = BoggleService.new
      response = bg.createNeighbouringMap(@column)
      setForU = response['U']
      testSet = ['c', 'L', 'W']
      testSet.each { |x|  }
      expect(response['U']).to be_instance_of Set
    end
  end

  context "when saving a word" do

    before(:each) do
      boggleMatrix = [
          ['U', 'C', 'K', 'U'],
          ['W', 'L', 'T', 'S'],
          ['R', 'M', 'D', 'G'],
          ['L', 'Y', 'R', 'O']
      ]
      @boogleService = BoggleService.new
      # @boogleService.setNeighbourhoodHash = boggleMatrix
      @boogleService.createNeighbouringMap(boggleMatrix)
    end
    it "should return true if the word is constructed from neighbouring letters" do
      testList = ["KUST", "UCKU", "LUCK", "DOGS", "gody", "ULKSDORMLRLU"]
      bg = BoggleService.new
      testList.each { |x|
        response = bg.validateWord(x)
        puts response
        expect(response).to be_truthy
      }
    end
    it "should return false if the word is not constructed from neighbouring letters" do
      testList = ["Hello", "JUST", "First"]
      bg = BoggleService.new
      testList.each { |x|
        response = bg.validateWord(x)
        puts response
        expect(response).to be_falsey
      }
    end
  end
end
