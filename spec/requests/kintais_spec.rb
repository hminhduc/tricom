require 'rails_helper'

RSpec.describe 'Kintais', type: :request do
  describe 'GET /kintais' do
    before do
      user = FactoryBot.create :user, password: 'abc123', admin: true
      post login_path, params: { session: { 担当者コード: user.id, password: 'abc123' } }
    end
    it 'index' do
      get kintais_path
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end

    it 'sumikakunin' do
      get sumikakunin_kintais_path
      expect(response).to render_template(:sumikakunin)
      expect(response).to have_http_status(200)
    end
  end
end
