require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'setsubiyoyakus/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:setsubiyoyaku) { FactoryBot.create :setsubiyoyaku }
  it 'displays all the setsubiyoyakus' do
    assign(:setsubiyoyakus, [setsubiyoyaku])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/setsubiyoyakus'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/setsubiyoyakus']")
  end
end
