require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'bunruis/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:bunrui) { FactoryBot.create :bunrui }
  it 'displays all the bunruis' do
    assign(:bunruis, [bunrui])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/bunruis'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/bunruis']")
  end
end
