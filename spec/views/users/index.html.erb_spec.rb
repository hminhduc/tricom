require 'rails_helper'
include SessionsHelper
include ApplicationHelper

RSpec.describe 'users/index.html.erb', type: :view do
  let(:user) { FactoryBot.create :user, :admin }
  let(:user1) { FactoryBot.create :user, :second }

  it 'displays all the users' do
    assign(:users, [user, user1])
    assign(:current_user, user)
    render
    expect(response).to have_text(user.担当者コード)
    expect(response).to have_text(user.担当者名称)
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/users'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/users']")
  end
end
