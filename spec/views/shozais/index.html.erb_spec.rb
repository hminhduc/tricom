require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'shozais/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:shozai) { FactoryBot.create :shozai }
  it 'displays all the shozais' do
    assign(:shozais, [shozai])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/shozais'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/shozais']")
  end
end
