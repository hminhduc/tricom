require 'rails_helper'

RSpec.describe "Ekis", type: :request do
  describe "GET /ekis" do
    it "works! (now write some real specs)" do
      get ekis_path
      expect(response).to have_http_status(302)
    end
  end
end
