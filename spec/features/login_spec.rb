require 'rails_helper'

RSpec.feature 'login', type: :feature do
  let(:user) { FactoryBot.create :user, password: 'abc123' }

  it 'normal' do
    visit login_path
    fill_in 'session_担当者コード', with: user.担当者コード
    fill_in 'session_password', with: 'abc123'
    click_button 'ログイン'
    expect(page).to have_link 'タイムライン'
  end

  it 'fail' do
    visit login_path
    fill_in 'session_担当者コード', with: user.担当者コード
    fill_in 'session_password', with: '123abc'
    click_button 'ログイン'
    expect(page).to have_button 'ログイン'
  end
end
