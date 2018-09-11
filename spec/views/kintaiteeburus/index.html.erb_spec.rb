require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'kintaiteeburus/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:kintaiteeburu) { FactoryBot.create :kintaiteeburu }
  it 'displays all the kintaiteeburus' do
    assign(:kintaiteeburus, [kintaiteeburu])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/kintaiteeburus'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/kintaiteeburus']")
  end
end
