require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'myjobmasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:myjobmaster) { FactoryBot.create :myjobmaster }
  it 'displays all the myjobmasters' do
    assign(:myjobmasters, [myjobmaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/myjobmasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/myjobmasters']")
  end
end
