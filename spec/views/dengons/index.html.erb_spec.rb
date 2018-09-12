require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'dengons/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:dengon) { FactoryBot.create :dengon }
  it 'displays all the dengons' do
    assign(:dengons, [dengon])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/dengons'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/dengons']")
  end
end
