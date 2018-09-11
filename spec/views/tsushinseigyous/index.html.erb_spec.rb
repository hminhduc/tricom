require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'tsushinseigyous/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:tsushinseigyou) { FactoryBot.create :tsushinseigyou }
  it 'displays all the tsushinseigyous' do
    assign(:tsushinseigyous, [tsushinseigyou])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/tsushinseigyous'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/tsushinseigyous']")
  end
end
