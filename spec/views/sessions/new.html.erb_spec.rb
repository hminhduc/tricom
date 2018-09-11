require 'rails_helper'
include ApplicationHelper

RSpec.describe 'sessions/new.html.erb', type: :view do
  it 'displays form login' do
    render
    expect(response).to have_field('担当者コード', type: :text)
    expect(response).to have_field('パスワード', type: :password)
    expect(response).to have_button('ログイン')
  end
end
