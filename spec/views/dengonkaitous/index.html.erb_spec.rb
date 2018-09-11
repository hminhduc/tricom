require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'dengonkaitous/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:dengonkaitou) { FactoryBot.create :dengonkaitou }
  it 'displays all the dengonkaitous' do
    assign(:dengonkaitous, [dengonkaitou])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/dengonkaitous'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/dengonkaitous']")
  end
end
