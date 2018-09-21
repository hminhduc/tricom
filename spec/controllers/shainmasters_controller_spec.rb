require 'rails_helper'

RSpec.describe ShainmastersController, type: :controller do
  let!(:shainmaster) { FactoryBot.create :shainmaster }
  let(:valid_session) { { current_user_id: FactoryBot.create(:user).id } }

  describe 'GET #index' do
    it 'assigns all shainmasters as @shainmasters' do
      get :index, session: valid_session
      expect(assigns(:shainmasters)).to eq(Shainmaster.all)
    end
  end
end
