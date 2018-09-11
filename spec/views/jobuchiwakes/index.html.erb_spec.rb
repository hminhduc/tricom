require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'kouteimasters/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:kouteimaster) { FactoryBot.create :kouteimaster }
  it 'displays all the kouteimasters' do
    assign(:kouteimasters, [kouteimaster])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/kouteimasters'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/kouteimasters']")
  end
end
