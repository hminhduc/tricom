require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'dengonyoukens/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:dengonyouken) { FactoryBot.create :dengonyouken }
  it 'displays all the dengonyoukens' do
    assign(:dengonyoukens, [dengonyouken])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/dengonyoukens'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/dengonyoukens']")
  end
end
