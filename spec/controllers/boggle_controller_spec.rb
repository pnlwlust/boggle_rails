require 'rails_helper'

RSpec.describe BoggleController, type: :controller do

  describe "GET #index" do
    it "returns a success response" do
      expect(response.key).to eq true
    end
  end
end