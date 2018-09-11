require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'bashokubunmsts/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:bashokubunmst) { FactoryBot.create :bashokubunmst }
  it 'displays all the bashokubunmsts' do
    assign(:bashokubunmsts, [bashokubunmst])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/bashokubunmsts'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/bashokubunmsts']")
  end
end
