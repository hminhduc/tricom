require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'sagyoukubuns/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:sagyoukubun) { FactoryBot.create :sagyoukubun }
  it 'displays all the sagyoukubuns' do
    assign(:sagyoukubuns, [sagyoukubun])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/sagyoukubuns'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/sagyoukubuns']")
  end
end
