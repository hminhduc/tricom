require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'settings/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:setting) { FactoryBot.create :setting }
  it 'displays all the settings' do
    assign(:settings, [setting])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/settings'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/settings']")
  end
end
