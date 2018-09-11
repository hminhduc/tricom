require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'jobuchiwakes/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:jobuchiwake) { FactoryBot.create :jobuchiwake }
  it 'displays all the jobuchiwakes' do
    assign(:jobuchiwakes, [jobuchiwake.decorate])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/jobuchiwakes'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/jobuchiwakes']")
  end
end
