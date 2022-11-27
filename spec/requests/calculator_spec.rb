require 'rails_helper'

RSpec.describe "Calculators", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get "/calculator/input"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /result" do
    it "returns http success" do
      get "/calculator/result"
      expect(response).to have_http_status(:success)
    end
  end

end
