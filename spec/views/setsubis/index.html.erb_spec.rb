require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'setsubis/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:setsubi) { FactoryBot.create :setsubi }
  it 'displays all the setsubis' do
    assign(:setsubis, [setsubi])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/setsubis'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/setsubis']")
  end
end
