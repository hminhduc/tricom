require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'jobmasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:jobmaster) { FactoryBot.create :jobmaster }
  it 'displays all the jobmasters' do
    assign(:jobmasters, [jobmaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/jobmasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/jobmasters']")
  end
end
