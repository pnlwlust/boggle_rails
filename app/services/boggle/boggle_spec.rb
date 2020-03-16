require 'rails_helper'

describe BoggleService do
  context 'When Testing the BoggleService class' do

    it "should say 'Hello World' when called start method" do

      bg = BoggleService.new
      response = bg.start
      expect(response).to eq 26
    end

  end
end