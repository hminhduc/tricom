require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'kaishamasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:kaishamaster) { FactoryBot.create :kaishamaster }
  it 'displays all the kaishamasters' do
    assign(:kaishamasters, [kaishamaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/kaishamasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/kaishamasters']")
  end
end
