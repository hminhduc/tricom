require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'mybashomasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:mybashomaster) { FactoryBot.create :mybashomaster }
  it 'displays all the mybashomasters' do
    assign(:mybashomasters, [mybashomaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/mybashomasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/mybashomasters']")
  end
end
