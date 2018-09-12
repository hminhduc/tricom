require 'rails_helper'

RSpec.describe 'Dengons', type: :request do
  describe 'GET /dengons' do
    before do
      user = FactoryBot.create :user, password: 'abc123', admin: true
      post login_path, params: { session: { 担当者コード: user.id, password: 'abc123' } }
    end
    it 'index' do
      get dengons_path
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end
end
