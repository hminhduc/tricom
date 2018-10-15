require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:event) { FactoryBot.create :event }
  let(:valid_session) { { current_user_id: FactoryBot.create(:user).id } }

  describe 'PUT #update' do
    before { @event = FactoryBot.create :event, 開始: '2018/08/01 09:00', 終了: '2018/08/01 17:00' }
    context 'with valid params' do
      let(:new_attributes) { { 社員番号: 'abc123', 開始: '2018/08/01 01:00' } }
      before { put :update, params: { id: @event.to_param, event: new_attributes, commit: I18n.t('helpers.submit.update') }, session: valid_session }
      it 'updates the requested event without 社員番号' do
        @event.reload
        expect(@event.開始).to eq('2018/08/01 01:00')
        expect(@event.社員番号).not_to eq('abc123')
      end
    end
  end
end
