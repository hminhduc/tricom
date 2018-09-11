require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'joutaimasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:joutaimaster) { FactoryBot.create :joutaimaster }
  it 'displays all the joutaimasters' do
    assign(:joutaimasters, [joutaimaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/joutaimasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/joutaimasters']")
  end
end
