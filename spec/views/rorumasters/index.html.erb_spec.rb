require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'rorumasters/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:rorumaster) { FactoryBot.create :rorumaster }
  it 'displays all the rorumasters' do
    assign(:rorumasters, [rorumaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/rorumasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/rorumasters']")
  end
end
