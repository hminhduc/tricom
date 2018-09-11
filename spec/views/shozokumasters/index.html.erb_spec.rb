require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'shozokumasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:shozokumaster) { FactoryBot.create :shozokumaster }
  it 'displays all the shozokumasters' do
    assign(:shozokumasters, [shozokumaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/shozokumasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/shozokumasters']")
  end
end
