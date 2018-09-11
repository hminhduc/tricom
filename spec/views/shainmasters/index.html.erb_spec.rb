require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'shainmasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:shainmaster) { FactoryBot.create :shainmaster }
  it 'displays all the shainmasters' do
    assign(:shainmasters, [shainmaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/shainmasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/shainmasters']")
  end
end
