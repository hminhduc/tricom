require 'rails_helper'

RSpec.feature 'event management', type: :feature do
  let(:user) { FactoryBot.create :user, password: 'abc123' }

  describe 'redirect after destroy event' do
    let(:event) { FactoryBot.create :event }
    before do
      visit login_path
      fill_in 'session_担当者コード', with: user.担当者コード
      fill_in 'session_password', with: 'abc123'
      click_button 'ログイン'
    end
    it 'back to time line view' do
      visit edit_event_path(event, param: 'timeline')
      expect(page).to have_link '削除'
      click_link '削除'
      expect(page).to have_current_path('/events/time_line_view?locale=ja')
    end
    it 'back to calendar' do
      visit edit_event_path(event, param: 'event')
      expect(page).to have_link '削除'
      click_link '削除'
      expect(page).to have_current_path('/events?locale=ja')
    end
  end
end
