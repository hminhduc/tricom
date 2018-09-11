require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'yuusens/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:yuusen) { FactoryBot.create :yuusen }
  it 'displays all the yuusens' do
    assign(:yuusens, [yuusen])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/yuusens'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/yuusens']")
  end
end
