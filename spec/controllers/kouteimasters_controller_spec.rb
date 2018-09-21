require 'rails_helper'

RSpec.describe KouteimastersController, type: :controller do
  let!(:kouteimaster) { FactoryBot.create :kouteimaster }
  let(:valid_session) { { current_user_id: FactoryBot.create(:user).id } }

  describe 'GET #index' do
    it 'assigns all kouteimasters as @kouteimasters' do
      get :index, session: valid_session
      expect(assigns(:kouteimasters)).to eq(Kouteimaster.all)
    end
  end
end
