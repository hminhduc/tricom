require 'rails_helper'

RSpec.describe 'Dengons', type: :request do
  describe 'GET /dengons' do
    it 'works! (now write some real specs)' do
      get dengons_path
      expect(response).to have_http_status(302)
    end
  end
end
