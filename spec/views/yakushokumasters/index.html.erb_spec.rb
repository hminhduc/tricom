require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'yakushokumasters/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:yakushokumaster) { FactoryBot.create :yakushokumaster }
  it 'displays all the yakushokumasters' do
    assign(:yakushokumasters, [yakushokumaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/yakushokumasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/yakushokumasters']")
  end
end
