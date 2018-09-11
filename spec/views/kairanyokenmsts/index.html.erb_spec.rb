require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'kairanyokenmsts/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:kairanyokenmst) { FactoryBot.create :kairanyokenmst }
  it 'displays all the kairanyokenmsts' do
    assign(:kairanyokenmsts, [kairanyokenmst])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/kairanyokenmsts'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/kairanyokenmsts']")
  end
end
